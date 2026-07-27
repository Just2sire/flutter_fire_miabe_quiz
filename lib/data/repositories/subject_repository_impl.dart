import "package:shared_preferences/shared_preferences.dart";

import "../../domain/entities/lesson.dart";
import "../../domain/entities/subject.dart";
import "../../domain/entities/unit.dart";
import "../../domain/repositories/subject_repository.dart";
import "../datasources/local_json_datasource.dart";
import "../models/lesson_model.dart";
import "../models/subject_model.dart";
import "../models/unit_model.dart";

class SubjectRepositoryImpl implements SubjectRepository {
  SubjectRepositoryImpl({LocalJsonDataSource? dataSource})
    : _dataSource = dataSource ?? LocalJsonDataSource.instance;
  final LocalJsonDataSource _dataSource;

  static const _completedLessonsKey = "completed_lesson_ids";

  @override
  Future<List<Subject>> getAllSubjects() async {
    final json = await _dataSource.loadList("subjects.json");
    return json.map((e) => SubjectModel.fromJson(e).toEntity()).toList();
  }

  @override
  Future<Subject?> getSubjectById(String id) async {
    final subjects = await getAllSubjects();
    try {
      return subjects.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Unit>> getUnitsBySubject(String subjectId) async {
    final json = await _dataSource.loadList("units.json");
    return json
        .map((e) => UnitModel.fromJson(e).toEntity())
        .where((u) => u.subjectId == subjectId)
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));
  }

  @override
  Future<List<Lesson>> getLessonsByUnit(String unitId) async {
    final completedIds = await _completedLessonIds();
    final json = await _dataSource.loadList("lessons.json");
    return json
        .map((e) => LessonModel.fromJson(e).toEntity())
        .map(
          (l) =>
              completedIds.contains(l.id) ? l.copyWith(isCompleted: true) : l,
        )
        .where((l) => l.unitId == unitId)
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));
  }

  @override
  Future<List<Lesson>> getLessonsBySubject(String subjectId) async {
    final completedIds = await _completedLessonIds();
    final json = await _dataSource.loadList("lessons.json");
    return json
        .map((e) => LessonModel.fromJson(e).toEntity())
        .map(
          (l) =>
              completedIds.contains(l.id) ? l.copyWith(isCompleted: true) : l,
        )
        .where((l) => l.subjectId == subjectId)
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));
  }

  @override
  Future<void> markLessonCompleted(String lessonId) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_completedLessonsKey) ?? [];
    if (!ids.contains(lessonId)) {
      ids.add(lessonId);
      await prefs.setStringList(_completedLessonsKey, ids);
    }
  }

  Future<Set<String>> _completedLessonIds() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_completedLessonsKey) ?? []).toSet();
  }
}
