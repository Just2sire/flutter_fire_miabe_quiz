import "package:flutter/foundation.dart";

import "../../domain/entities/box.dart";
import "../../domain/entities/enums.dart";

/// `closesInHours` (et non une date figée) permet au JSON de seed de
/// rester réaliste : le compte à rebours repart de cette durée à chaque
/// lancement de l'app, comme "Box closes in: 28:45:50" dans la maquette.
class BoxModel {
  const BoxModel({
    required this.id,
    required this.title,
    required this.questionIds,
    required this.closesInHours,
    required this.status,
  });

  factory BoxModel.fromMap(Map<String, dynamic> map) {
    return BoxModel(
      id: map["id"] as String? ?? "",
      title: map["title"] as String? ?? "",
      questionIds: (map["questionIds"] as List?)?.cast<String>() ?? [],
      closesInHours: (map["closesInHours"] as num?)?.toDouble() ?? 0.0,
      status: map["status"] as String? ?? "open",
    );
  }

  factory BoxModel.fromJson(Map<String, dynamic> json) =>
      BoxModel.fromMap(json);

  factory BoxModel.fromEntity(Box box) => BoxModel(
    id: box.id,
    title: box.title,
    questionIds: box.questionIds,
    closesInHours: box.closesAt.difference(DateTime.now()).inMinutes / 60.0,
    status: box.status.name,
  );
  final String id;
  final String title;
  final List<String> questionIds;
  final double closesInHours;
  final String status;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "questionIds": questionIds,
      "closesInHours": closesInHours,
      "status": status,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  Box toEntity() => Box(
    id: id,
    title: title,
    questionIds: questionIds,
    closesAt: DateTime.now().add(
      Duration(minutes: (closesInHours * 60).round()),
    ),
    status: BoxStatus.values.firstWhere(
      (s) => s.name == status,
      orElse: () => BoxStatus.open,
    ),
  );

  BoxModel copyWith({
    String? id,
    String? title,
    List<String>? questionIds,
    double? closesInHours,
    String? status,
  }) {
    return BoxModel(
      id: id ?? this.id,
      title: title ?? this.title,
      questionIds: questionIds ?? this.questionIds,
      closesInHours: closesInHours ?? this.closesInHours,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return "BoxModel(id: $id, title: $title, questionIds: $questionIds, "
    "closesInHours: $closesInHours, status: $status)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BoxModel &&
        other.id == id &&
        other.title == title &&
        listEquals(other.questionIds, questionIds) &&
        other.closesInHours == closesInHours &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        questionIds.hashCode ^
        closesInHours.hashCode ^
        status.hashCode;
  }
}
