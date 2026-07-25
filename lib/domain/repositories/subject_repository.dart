import "../entities/lesson.dart";
import "../entities/subject.dart";
import "../entities/unit.dart";

/// Contrat d'accès aux matières et à leur contenu pédagogique.
/// L'implémentation (JSON local, puis API plus tard) vit en couche data.
abstract class SubjectRepository {
  Future<List<Subject>> getAllSubjects();
  Future<Subject?> getSubjectById(String id);

  Future<List<Unit>> getUnitsBySubject(String subjectId);
  Future<List<Lesson>> getLessonsByUnit(String unitId);
  Future<List<Lesson>> getLessonsBySubject(String subjectId);

  /// Marque une leçon comme terminée (persistance locale).
  Future<void> markLessonCompleted(String lessonId);
}
