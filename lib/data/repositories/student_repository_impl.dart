import "dart:convert";

import "package:shared_preferences/shared_preferences.dart";

import "../../domain/entities/index.dart";
import "../../domain/repositories/student_repository.dart";
import "../datasources/local_json_datasource.dart";
import "../models/quiz_attempt_model.dart";
import "../models/student_model.dart";

class StudentRepositoryImpl implements StudentRepository {
  StudentRepositoryImpl({LocalJsonDataSource? dataSource})
    : _dataSource = dataSource ?? LocalJsonDataSource.instance;
  final LocalJsonDataSource _dataSource;

  static const _studentKey = "current_student";
  static const _historyKey = "quiz_attempt_history";

  @override
  Future<Student> getCurrentStudent() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_studentKey);
    if (raw != null) {
      return StudentModel.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      ).toEntity();
    }
    // Premier lancement : on part du profil de démo packagé en asset.
    final seed = await _dataSource.loadObject("students.json");
    final student = StudentModel.fromJson(seed).toEntity();
    await updateStudent(student);
    return student;
  }

  @override
  Future<void> updateStudent(Student student) async {
    final prefs = await SharedPreferences.getInstance();
    final model = StudentModel.fromEntity(student);
    await prefs.setString(_studentKey, jsonEncode(model.toJson()));
  }

  @override
  Future<List<QuizAttempt>> getAttemptHistory(String studentId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_historyKey) ?? [];
    return raw
        .map(
          (e) => QuizAttemptModel.fromJson(
            jsonDecode(e) as Map<String, dynamic>,
          ).toEntity(),
        )
        .where((a) => a.studentId == studentId)
        .toList()
      ..sort((a, b) => b.startedAt.compareTo(a.startedAt));
  }

  @override
  Future<void> saveAttempt(QuizAttempt attempt) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_historyKey) ?? []
      ..add(jsonEncode(QuizAttemptModel.fromEntity(attempt).toJson()));
    await prefs.setStringList(_historyKey, raw);

    // Met à jour les compteurs cache du profil.
    final student = await getCurrentStudent();
    await updateStudent(
      student.copyWith(
        totalPoints: student.totalPoints + attempt.score,
        completedQuizzesCount: attempt.isCompleted
            ? student.completedQuizzesCount + 1
            : student.completedQuizzesCount,
      ),
    );
  }

  @override
  Future<void> resetAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_studentKey);
    await prefs.remove(_historyKey);
    await prefs.remove("quiz_progress_overrides");
    await prefs.remove("completed_lesson_ids");
  }
}
