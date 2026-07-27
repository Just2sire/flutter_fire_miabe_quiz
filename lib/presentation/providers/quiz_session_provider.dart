import "dart:async";

import "package:flutter/material.dart";
import "package:miabe_quiz/domain/entities/index.dart"
    show DifficultyLevel, AttemptSourceType, Question, Difficulty, QuizAttempt;
import "package:miabe_quiz/domain/repositories/index.dart"
    show StudentRepository, QuestionRepository, QuizRepository;

enum AnswerState { unanswered, correct, incorrect }

/// Pilote une session de jeu unique (un Quiz ou une Box en cours). Une
/// nouvelle instance est créée à chaque lancement de partie (via
/// ChangeNotifierProvider en route param), plutôt qu'un singleton global.
class QuizSessionProvider extends ChangeNotifier {
  QuizSessionProvider({
    required this._questionRepository,
    required this._studentRepository,
    this._quizRepository,
  });
  final QuestionRepository _questionRepository;
  final StudentRepository _studentRepository;
  final QuizRepository? _quizRepository;

  List<Question> _questions = [];
  List<Question> get questions => _questions;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  int? _selectedOption;
  int? get selectedOption => _selectedOption;

  AnswerState _answerState = AnswerState.unanswered;
  AnswerState get answerState => _answerState;

  int _correctCount = 0;
  int _wrongCount = 0;
  int _score = 0;
  int get score => _score;
  int get correctCount => _correctCount;
  int get wrongCount => _wrongCount;

  final Map<String, int> _answers = {};

  late DifficultyLevel _difficultyLevel;
  int _timeLeft = 0;
  int get timeLeft => _timeLeft;
  Timer? _timer;

  late DateTime _startedAt;
  late String _studentId;
  late String _sourceId;
  late AttemptSourceType _sourceType;

  bool get isLastQuestion => _currentIndex >= _questions.length - 1;
  bool get isFinished =>
      _questions.isNotEmpty && _currentIndex >= _questions.length;

  Question get currentQuestion => _questions[_currentIndex];

  Future<void> start({
    required List<String> questionIds,
    required String studentId,
    required String sourceId,
    required AttemptSourceType sourceType,
    Difficulty difficulty = Difficulty.medium,
  }) async {
    _questions = await _questionRepository.getQuestionsByIds(questionIds);
    _difficultyLevel = await _questionRepository.getDifficultyLevel(difficulty);
    _studentId = studentId;
    _sourceId = sourceId;
    _sourceType = sourceType;
    _startedAt = DateTime.now();
    _currentIndex = 0;
    _correctCount = 0;
    _wrongCount = 0;
    _score = 0;
    _answers.clear();
    _startTimerForCurrentQuestion();
    notifyListeners();
  }

  void _startTimerForCurrentQuestion() {
    _timer?.cancel();
    _selectedOption = null;
    _answerState = AnswerState.unanswered;
    _timeLeft = _difficultyLevel.timePerQuestionSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_timeLeft <= 1) {
        _timer?.cancel();
        if (_answerState == AnswerState.unanswered) {
          submitAnswer(-1); // timeout : aucune option choisie
        }
      } else {
        _timeLeft--;
        notifyListeners();
      }
    });
  }

  void submitAnswer(int optionIndex) {
    if (_answerState != AnswerState.unanswered) return;
    _timer?.cancel();
    _selectedOption = optionIndex;
    final question = currentQuestion;
    final correct = question.isCorrect(optionIndex);
    _answerState = correct ? AnswerState.correct : AnswerState.incorrect;
    _answers[question.id] = optionIndex;

    if (correct) {
      _correctCount++;
      _score += question.points * _difficultyLevel.pointsPerCorrect;
    } else {
      _wrongCount++;
    }
    notifyListeners();
  }

  Future<void> nextQuestion() async {
    _currentIndex++;
    if (isFinished) {
      await _persistAttempt();
    } else {
      _startTimerForCurrentQuestion();
    }
    notifyListeners();
  }

  Future<void> _persistAttempt() async {
    final attempt = QuizAttempt(
      id: "${_sourceId}_${_startedAt.millisecondsSinceEpoch}",
      studentId: _studentId,
      sourceId: _sourceId,
      sourceType: _sourceType,
      startedAt: _startedAt,
      completedAt: DateTime.now(),
      answers: Map.of(_answers),
      correctCount: _correctCount,
      wrongCount: _wrongCount,
      score: _score,
    );
    await _studentRepository.saveAttempt(attempt);
    if (_sourceType == AttemptSourceType.quiz && _quizRepository != null) {
      await _quizRepository.updateQuizProgress(_sourceId, 1.0);
    }
  }

  void abandon() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
