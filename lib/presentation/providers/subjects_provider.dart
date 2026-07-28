import "package:flutter/material.dart";
import "package:miabe_quiz/domain/entities/index.dart"
    show Subject, Lesson, Unit, Quiz;
import "package:miabe_quiz/domain/repositories/index.dart"
    show SubjectRepository, QuizRepository;

enum LoadStatus { idle, loading, loaded, error }

class SubjectsProvider extends ChangeNotifier {
  SubjectsProvider(this._repository, this._quizRepository);

  final SubjectRepository _repository;
  final QuizRepository _quizRepository;

  LoadStatus _status = LoadStatus.idle;
  LoadStatus get status => _status;

  List<Subject> _subjects = [];
  List<Subject> get subjects => _subjects;

  String _searchQuery = "";
  String get searchQuery => _searchQuery;

  List<Subject> get filteredSubjects {
    if (_searchQuery.trim().isEmpty) return _subjects;
    final q = _searchQuery.toLowerCase();
    return _subjects.where((s) => s.name.toLowerCase().contains(q)).toList();
  }

  Future<void> loadSubjects() async {
    _status = LoadStatus.loading;
    notifyListeners();
    try {
      _subjects = await _repository.getAllSubjects();
      _status = LoadStatus.loaded;
    } catch (_) {
      _status = LoadStatus.error;
    }
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<Subject?> getSubjectById(String id) async {
    try {
      return _subjects.firstWhere((s) => s.id == id);
    } catch (_) {
      return _repository.getSubjectById(id);
    }
  }

  Future<List<Unit>> unitsFor(String subjectId) =>
      _repository.getUnitsBySubject(subjectId);

  Future<List<Lesson>> lessonsForUnit(String unitId) =>
      _repository.getLessonsByUnit(unitId);

  Future<List<Lesson>> lessonsForSubject(String subjectId) =>
      _repository.getLessonsBySubject(subjectId);

  Future<Lesson?> getLessonById(String lessonId) =>
      _repository.getLessonById(lessonId);

  Future<List<Quiz>> quizzesForSubject(String subjectId) =>
      _quizRepository.getQuizzesBySubject(subjectId);

  Future<List<Quiz>> quizzesForUnit(String unitId) =>
      _quizRepository.getQuizzesByUnit(unitId);

  Future<Quiz?> getQuizById(String quizId) =>
      _quizRepository.getQuizById(quizId);

  Future<void> markLessonCompleted(String lessonId) =>
      _repository.markLessonCompleted(lessonId);
}
