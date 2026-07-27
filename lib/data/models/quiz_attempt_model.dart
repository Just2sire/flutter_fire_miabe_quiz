import "package:flutter/foundation.dart";

import "../../domain/entities/enums.dart" show AttemptSourceType;
import "../../domain/entities/quiz_attempt.dart";

class QuizAttemptModel {

  const QuizAttemptModel({
    required this.id,
    required this.studentId,
    required this.sourceId,
    required this.sourceType,
    required this.startedAt,
    required this.answers,
    required this.correctCount,
    required this.wrongCount,
    required this.score,
    this.completedAt,
  });

  factory QuizAttemptModel.fromMap(Map<String, dynamic> map) {
    return QuizAttemptModel(
      id: map["id"] as String? ?? "",
      studentId: map["studentId"] as String? ?? "",
      sourceId: map["sourceId"] as String? ?? "",
      sourceType: map["sourceType"] as String? ?? "",
      startedAt: map["startedAt"] as String? ?? "",
      completedAt: map["completedAt"] as String?,
      answers: Map<String, int>.from(map["answers"] as Map? ?? {}),
      correctCount: (map["correctCount"] as num?)?.toInt() ?? 0,
      wrongCount: (map["wrongCount"] as num?)?.toInt() ?? 0,
      score: (map["score"] as num?)?.toInt() ?? 0,
    );
  }

  factory QuizAttemptModel.fromJson(Map<String, dynamic> json) =>
      QuizAttemptModel.fromMap(json);

  factory QuizAttemptModel.fromEntity(QuizAttempt a) => QuizAttemptModel(
        id: a.id,
        studentId: a.studentId,
        sourceId: a.sourceId,
        sourceType: a.sourceType.name,
        startedAt: a.startedAt.toIso8601String(),
        completedAt: a.completedAt?.toIso8601String(),
        answers: a.answers,
        correctCount: a.correctCount,
        wrongCount: a.wrongCount,
        score: a.score,
      );
  final String id;
  final String studentId;
  final String sourceId;
  final String sourceType;
  final String startedAt;
  final String? completedAt;
  final Map<String, int> answers;
  final int correctCount;
  final int wrongCount;
  final int score;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "studentId": studentId,
      "sourceId": sourceId,
      "sourceType": sourceType,
      "startedAt": startedAt,
      "completedAt": completedAt,
      "answers": answers,
      "correctCount": correctCount,
      "wrongCount": wrongCount,
      "score": score,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  QuizAttempt toEntity() => QuizAttempt(
        id: id,
        studentId: studentId,
        sourceId: sourceId,
        sourceType: AttemptSourceType.values.firstWhere(
          (t) => t.name == sourceType,
          orElse: () => AttemptSourceType.quiz,
        ),
        startedAt: DateTime.parse(startedAt),
        completedAt: completedAt != null ? DateTime.parse(completedAt!) : null,
        answers: answers,
        correctCount: correctCount,
        wrongCount: wrongCount,
        score: score,
      );

  QuizAttemptModel copyWith({
    String? id,
    String? studentId,
    String? sourceId,
    String? sourceType,
    String? startedAt,
    ValueGetter<String?>? completedAt,
    Map<String, int>? answers,
    int? correctCount,
    int? wrongCount,
    int? score,
  }) {
    return QuizAttemptModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      sourceId: sourceId ?? this.sourceId,
      sourceType: sourceType ?? this.sourceType,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt != null ? completedAt() : this.completedAt,
      answers: answers ?? this.answers,
      correctCount: correctCount ?? this.correctCount,
      wrongCount: wrongCount ?? this.wrongCount,
      score: score ?? this.score,
    );
  }

  @override
  String toString() {
    return "QuizAttemptModel(id: $id, studentId: $studentId, sourceId: "
        "$sourceId, sourceType: $sourceType, startedAt: $startedAt, "
        "completedAt: $completedAt, answers: $answers, correctCount: "
        "$correctCount, wrongCount: $wrongCount, score: $score)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuizAttemptModel &&
        other.id == id &&
        other.studentId == studentId &&
        other.sourceId == sourceId &&
        other.sourceType == sourceType &&
        other.startedAt == startedAt &&
        other.completedAt == completedAt &&
        mapEquals(other.answers, answers) &&
        other.correctCount == correctCount &&
        other.wrongCount == wrongCount &&
        other.score == score;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        studentId.hashCode ^
        sourceId.hashCode ^
        sourceType.hashCode ^
        startedAt.hashCode ^
        completedAt.hashCode ^
        answers.hashCode ^
        correctCount.hashCode ^
        wrongCount.hashCode ^
        score.hashCode;
  }
}
