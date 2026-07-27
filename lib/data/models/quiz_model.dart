import "package:flutter/foundation.dart";

import "../../domain/entities/enums.dart";
import "../../domain/entities/quiz.dart";

class QuizModel {

  const QuizModel({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.questionIds,
    required this.status,
    required this.progress,
    this.unitId,
  });

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      id: map["id"] as String? ?? "",
      subjectId: map["subjectId"] as String? ?? "",
      unitId: map["unitId"] as String?,
      title: map["title"] as String? ?? "",
      questionIds: (map["questionIds"] as List?)?.cast<String>() ?? [],
      status: map["status"] as String? ?? "notStarted",
      progress: (map["progress"] as num?)?.toDouble() ?? 0.0,
    );
  }

  factory QuizModel.fromJson(Map<String, dynamic> json) =>
      QuizModel.fromMap(json);

  factory QuizModel.fromEntity(Quiz quiz) => QuizModel(
        id: quiz.id,
        subjectId: quiz.subjectId,
        unitId: quiz.unitId,
        title: quiz.title,
        questionIds: quiz.questionIds,
        status: quiz.status.name,
        progress: quiz.progress,
      );
  final String id;
  final String subjectId;
  final String? unitId;
  final String title;
  final List<String> questionIds;
  final String status;
  final double progress;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "subjectId": subjectId,
      "unitId": unitId,
      "title": title,
      "questionIds": questionIds,
      "status": status,
      "progress": progress,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  Quiz toEntity() => Quiz(
        id: id,
        subjectId: subjectId,
        unitId: unitId,
        title: title,
        questionIds: questionIds,
        status: QuizStatus.values.firstWhere(
          (s) => s.name == status,
          orElse: () => QuizStatus.notStarted,
        ),
        progress: progress,
      );

  QuizModel copyWith({
    String? id,
    String? subjectId,
    ValueGetter<String?>? unitId,
    String? title,
    List<String>? questionIds,
    String? status,
    double? progress,
  }) {
    return QuizModel(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      unitId: unitId != null ? unitId() : this.unitId,
      title: title ?? this.title,
      questionIds: questionIds ?? this.questionIds,
      status: status ?? this.status,
      progress: progress ?? this.progress,
    );
  }

  @override
  String toString() {
    return "QuizModel(id: $id, subjectId: $subjectId, unitId: $unitId, title:"
    " $title, questionIds: $questionIds, status: $status, progress: $progress)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuizModel &&
        other.id == id &&
        other.subjectId == subjectId &&
        other.unitId == unitId &&
        other.title == title &&
        listEquals(other.questionIds, questionIds) &&
        other.status == status &&
        other.progress == progress;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        subjectId.hashCode ^
        unitId.hashCode ^
        title.hashCode ^
        questionIds.hashCode ^
        status.hashCode ^
        progress.hashCode;
  }
}
