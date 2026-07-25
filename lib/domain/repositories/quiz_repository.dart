import "../entities/box.dart";
import "../entities/quiz.dart";

/// Contrat d'accès aux quiz classiques rattachés aux matières/unités.
abstract class QuizRepository {
  Future<List<Quiz>> getAllQuizzes();
  Future<List<Quiz>> getQuizzesBySubject(String subjectId);
  Future<Quiz?> getQuizById(String id);
  Future<void> updateQuizProgress(String quizId, double progress);
}

/// Contrat d'accès aux Box (défis chronométrés multi-questions).
abstract class BoxRepository {
  Future<List<Box>> getAllBoxes();
  Future<Box?> getBoxById(String id);
}
