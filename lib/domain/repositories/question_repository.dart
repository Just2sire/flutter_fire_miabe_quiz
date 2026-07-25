import "../entities/difficulty_level.dart";
import "../entities/enums.dart";
import "../entities/question.dart";

/// Contrat d'accès à la banque de questions et aux niveaux de difficulté.
abstract class QuestionRepository {
  Future<List<Question>> getAllQuestions();
  Future<List<Question>> getQuestionsByIds(List<String> ids);
  Future<List<Question>> getQuestionsBySubject(
    String subjectId, {
    Difficulty? difficulty,
  });

  Future<List<DifficultyLevel>> getDifficultyLevels();
  Future<DifficultyLevel> getDifficultyLevel(Difficulty difficulty);
}
