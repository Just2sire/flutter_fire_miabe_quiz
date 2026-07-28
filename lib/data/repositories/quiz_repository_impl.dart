import "dart:convert";

import "package:shared_preferences/shared_preferences.dart";

import "../../domain/entities/box.dart";
import "../../domain/entities/quiz.dart";
import "../../domain/repositories/quiz_repository.dart";
import "../datasources/local_json_datasource.dart";
import "../models/box_model.dart";
import "../models/quiz_model.dart";

class QuizRepositoryImpl implements QuizRepository {

  QuizRepositoryImpl({LocalJsonDataSource? dataSource})
    : _dataSource = dataSource ?? LocalJsonDataSource.instance;
  final LocalJsonDataSource _dataSource;

  static const _progressOverridesKey = "quiz_progress_overrides";

  @override
  Future<List<Quiz>> getAllQuizzes() async {
    final overrides = await _progressOverrides();
    final json = await _dataSource.loadList("quizzes.json");
    return json.map((e) {
      final quiz = QuizModel.fromJson(e).toEntity();
      final override = overrides[quiz.id];
      return override == null ? quiz : quiz.copyWith(progress: override);
    }).toList();
  }

  @override
  Future<List<Quiz>> getQuizzesBySubject(String subjectId) async {
    final all = await getAllQuizzes();
    return all.where((q) => q.subjectId == subjectId).toList();
  }

  @override
  Future<List<Quiz>> getQuizzesByUnit(String unitId) async {
    final all = await getAllQuizzes();
    return all.where((q) => q.unitId == unitId).toList();
  }

  @override
  Future<Quiz?> getQuizById(String id) async {
    final all = await getAllQuizzes();
    try {
      return all.firstWhere((q) => q.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> updateQuizProgress(String quizId, double progress) async {
    final prefs = await SharedPreferences.getInstance();
    final overrides = await _progressOverrides();
    overrides[quizId] = progress;
    await prefs.setString(_progressOverridesKey, jsonEncode(overrides));
  }

  Future<Map<String, double>> _progressOverrides() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_progressOverridesKey);
    if (raw == null) return {};
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map((k, v) => MapEntry(k, (v as num).toDouble()));
  }
}

class BoxRepositoryImpl implements BoxRepository {

  BoxRepositoryImpl({LocalJsonDataSource? dataSource})
    : _dataSource = dataSource ?? LocalJsonDataSource.instance;
  final LocalJsonDataSource _dataSource;

  @override
  Future<List<Box>> getAllBoxes() async {
    final json = await _dataSource.loadList("boxes.json");
    return json.map((e) => BoxModel.fromJson(e).toEntity()).toList();
  }

  @override
  Future<Box?> getBoxById(String id) async {
    final all = await getAllBoxes();
    try {
      return all.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }
}
