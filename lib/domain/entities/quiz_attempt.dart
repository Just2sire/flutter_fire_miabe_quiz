import "box.dart";
import "enums.dart";
import "quiz.dart";

/// Résultat d'une session de jeu (sur un [Quiz] ou une [Box]) pour un
/// étudiant donné. C'est l'entité persistée dans l'historique.
class QuizAttempt {
  const QuizAttempt({
    required this.id,
    required this.studentId,
    required this.sourceId,
    required this.sourceType,
    required this.startedAt,
    required this.answers,
    required this.correctCount,
    required this.wrongCount,
    required this.score,
    this.completedAt,
  });

  final String id;
  final String studentId;
  final String sourceId;
  final AttemptSourceType sourceType;
  final DateTime startedAt;
  final DateTime? completedAt;

  /// questionId -> index de l'option choisie
  final Map<String, int> answers;

  final int correctCount;
  final int wrongCount;
  final int score;

  int get totalAnswered => correctCount + wrongCount;

  double get percentage =>
      totalAnswered == 0 ? 0 : (correctCount / totalAnswered) * 100;

  Duration? get duration => completedAt?.difference(startedAt);

  bool get isCompleted => completedAt != null;

  @override
  bool operator ==(Object other) => other is QuizAttempt && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
