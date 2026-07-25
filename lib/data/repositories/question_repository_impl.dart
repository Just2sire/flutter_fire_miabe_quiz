import "../../domain/entities/index.dart";
import "../../domain/repositories/question_repository.dart";
import "../datasources/local_json_datasource.dart";
import "../models/difficulty_level_model.dart";
import "../models/question_model.dart";

class QuestionRepositoryImpl implements QuestionRepository {

  QuestionRepositoryImpl({LocalJsonDataSource? dataSource})
    : _dataSource = dataSource ?? LocalJsonDataSource.instance;
  final LocalJsonDataSource _dataSource;

  @override
  Future<List<Question>> getAllQuestions() async {
    final json = await _dataSource.loadList("questions.json");
    return json.map((e) => QuestionModel.fromJson(e).toEntity()).toList();
  }

  @override
  Future<List<Question>> getQuestionsByIds(List<String> ids) async {
    final all = await getAllQuestions();
    final byId = {for (final q in all) q.id: q};
    return ids.map((id) => byId[id]).whereType<Question>().toList();
  }

  @override
  Future<List<Question>> getQuestionsBySubject(
    String subjectId, {
    Difficulty? difficulty,
  }) async {
    final all = await getAllQuestions();
    return all
        .where((q) => q.subjectId == subjectId)
        .where((q) => difficulty == null || q.difficulty == difficulty)
        .toList();
  }

  @override
  Future<List<DifficultyLevel>> getDifficultyLevels() async {
    final json = await _dataSource.loadList("difficulty_levels.json");
    return json
        .map((e) => DifficultyLevelModel.fromJson(e).toEntity())
        .toList();
  }

  @override
  Future<DifficultyLevel> getDifficultyLevel(Difficulty difficulty) async {
    final levels = await getDifficultyLevels();
    return levels.firstWhere(
      (l) => l.id == difficulty,
      orElse: () => levels.first,
    );
  }
}
