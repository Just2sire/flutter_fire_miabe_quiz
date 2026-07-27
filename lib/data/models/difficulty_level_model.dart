import "../../domain/entities/difficulty_level.dart";
import "../../domain/entities/enums.dart";

class DifficultyLevelModel {
  const DifficultyLevelModel({
    required this.id,
    required this.name,
    required this.timePerQuestionSeconds,
    required this.pointsPerCorrect,
    required this.description,
  });

  factory DifficultyLevelModel.fromMap(Map<String, dynamic> map) {
    return DifficultyLevelModel(
      id: map["id"] as String? ?? "",
      name: map["name"] as String? ?? "",
      timePerQuestionSeconds:
          (map["timePerQuestionSeconds"] as num?)?.toInt() ?? 0,
      pointsPerCorrect: (map["pointsPerCorrect"] as num?)?.toInt() ?? 0,
      description: map["description"] as String? ?? "",
    );
  }

  factory DifficultyLevelModel.fromJson(Map<String, dynamic> json) =>
      DifficultyLevelModel.fromMap(json);

  factory DifficultyLevelModel.fromEntity(DifficultyLevel level) =>
      DifficultyLevelModel(
        id: level.id.name,
        name: level.name,
        timePerQuestionSeconds: level.timePerQuestionSeconds,
        pointsPerCorrect: level.pointsPerCorrect,
        description: level.description,
      );
  final String id;
  final String name;
  final int timePerQuestionSeconds;
  final int pointsPerCorrect;
  final String description;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "timePerQuestionSeconds": timePerQuestionSeconds,
      "pointsPerCorrect": pointsPerCorrect,
      "description": description,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  Difficulty get _difficultyEnum => Difficulty.values.firstWhere(
    (d) => d.name == id,
    orElse: () => Difficulty.easy,
  );

  DifficultyLevel toEntity() => DifficultyLevel(
    id: _difficultyEnum,
    name: name,
    timePerQuestionSeconds: timePerQuestionSeconds,
    pointsPerCorrect: pointsPerCorrect,
    description: description,
  );

  DifficultyLevelModel copyWith({
    String? id,
    String? name,
    int? timePerQuestionSeconds,
    int? pointsPerCorrect,
    String? description,
  }) {
    return DifficultyLevelModel(
      id: id ?? this.id,
      name: name ?? this.name,
      timePerQuestionSeconds:
          timePerQuestionSeconds ?? this.timePerQuestionSeconds,
      pointsPerCorrect: pointsPerCorrect ?? this.pointsPerCorrect,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return "DifficultyLevelModel(id: $id, name: $name, timePerQuestionSeconds: "
        "$timePerQuestionSeconds, pointsPerCorrect: $pointsPerCorrect," 
        " description: $description)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DifficultyLevelModel &&
        other.id == id &&
        other.name == name &&
        other.timePerQuestionSeconds == timePerQuestionSeconds &&
        other.pointsPerCorrect == pointsPerCorrect &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        timePerQuestionSeconds.hashCode ^
        pointsPerCorrect.hashCode ^
        description.hashCode;
  }
}
