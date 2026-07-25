import "../entities/quiz_attempt.dart";
import "../entities/student.dart";

/// Contrat d'accès au profil de l'étudiant courant et à son historique.
abstract class StudentRepository {
  Future<Student> getCurrentStudent();
  Future<void> updateStudent(Student student);

  Future<List<QuizAttempt>> getAttemptHistory(String studentId);
  Future<void> saveAttempt(QuizAttempt attempt);
  Future<void> resetAllData();
}
