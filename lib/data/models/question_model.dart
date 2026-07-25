import 'package:flutter/foundation.dart';

import "../../domain/entities/enums.dart" show Difficulty;
import "../../domain/entities/question.dart";

class QuestionModel {
  final String id;
  final String subjectId;
  final String difficulty;
  final String text;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;
  final int points;

  const QuestionModel({
    required this.id,
    required this.subjectId,
    required this.difficulty,
    required this.text,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
    required this.points,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'] as String? ?? '',
      subjectId: map['subjectId'] as String? ?? '',
      difficulty: map['difficulty'] as String? ?? '',
      text: map['text'] as String? ?? '',
      options: (map['options'] as List?)?.cast<String>() ?? [],
      correctOptionIndex: (map['correctOptionIndex'] as num?)?.toInt() ?? 0,
      explanation: map['explanation'] as String? ?? '',
      points: (map['points'] as num?)?.toInt() ?? 0,
    );
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      QuestionModel.fromMap(json);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subjectId': subjectId,
      'difficulty': difficulty,
      'text': text,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
      'explanation': explanation,
      'points': points,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  factory QuestionModel.fromEntity(Question question) => QuestionModel(
        id: question.id,
        subjectId: question.subjectId,
        difficulty: question.difficulty.name,
        text: question.text,
        options: question.options,
        correctOptionIndex: question.correctOptionIndex,
        explanation: question.explanation,
        points: question.points,
      );

  Question toEntity() => Question(
        id: id,
        subjectId: subjectId,
        difficulty: Difficulty.values.firstWhere(
          (d) => d.name == difficulty,
          orElse: () => Difficulty.easy,
        ),
        text: text,
        options: options,
        correctOptionIndex: correctOptionIndex,
        explanation: explanation,
        points: points,
      );

  QuestionModel copyWith({
    String? id,
    String? subjectId,
    String? difficulty,
    String? text,
    List<String>? options,
    int? correctOptionIndex,
    String? explanation,
    int? points,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      difficulty: difficulty ?? this.difficulty,
      text: text ?? this.text,
      options: options ?? this.options,
      correctOptionIndex: correctOptionIndex ?? this.correctOptionIndex,
      explanation: explanation ?? this.explanation,
      points: points ?? this.points,
    );
  }

  @override
  String toString() {
    return 'QuestionModel(id: $id, subjectId: $subjectId, difficulty: $difficulty, text: $text, options: $options, correctOptionIndex: $correctOptionIndex, explanation: $explanation, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuestionModel &&
        other.id == id &&
        other.subjectId == subjectId &&
        other.difficulty == difficulty &&
        other.text == text &&
        listEquals(other.options, options) &&
        other.correctOptionIndex == correctOptionIndex &&
        other.explanation == explanation &&
        other.points == points;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        subjectId.hashCode ^
        difficulty.hashCode ^
        text.hashCode ^
        options.hashCode ^
        correctOptionIndex.hashCode ^
        explanation.hashCode ^
        points.hashCode;
  }
}
