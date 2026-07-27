import "../../domain/entities/lesson.dart";

class LessonModel {
  const LessonModel({
    required this.id,
    required this.unitId,
    required this.subjectId,
    required this.title,
    required this.order,
    required this.durationMinutes,
    required this.thumbnailAsset,
    required this.isCompleted,
  });

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      id: map["id"] as String? ?? "",
      unitId: map["unitId"] as String? ?? "",
      subjectId: map["subjectId"] as String? ?? "",
      title: map["title"] as String? ?? "",
      order: (map["order"] as num?)?.toInt() ?? 0,
      durationMinutes: (map["durationMinutes"] as num?)?.toInt() ?? 0,
      thumbnailAsset: map["thumbnailAsset"] as String? ?? "",
      isCompleted: map["isCompleted"] as bool? ?? false,
    );
  }

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      LessonModel.fromMap(json);

  factory LessonModel.fromEntity(Lesson lesson) => LessonModel(
    id: lesson.id,
    unitId: lesson.unitId,
    subjectId: lesson.subjectId,
    title: lesson.title,
    order: lesson.order,
    durationMinutes: lesson.durationMinutes,
    thumbnailAsset: lesson.thumbnailAsset,
    isCompleted: lesson.isCompleted,
  );
  final String id;
  final String unitId;
  final String subjectId;
  final String title;
  final int order;
  final int durationMinutes;
  final String thumbnailAsset;
  final bool isCompleted;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "unitId": unitId,
      "subjectId": subjectId,
      "title": title,
      "order": order,
      "durationMinutes": durationMinutes,
      "thumbnailAsset": thumbnailAsset,
      "isCompleted": isCompleted,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  Lesson toEntity() => Lesson(
    id: id,
    unitId: unitId,
    subjectId: subjectId,
    title: title,
    order: order,
    durationMinutes: durationMinutes,
    thumbnailAsset: thumbnailAsset,
    isCompleted: isCompleted,
  );

  LessonModel copyWith({
    String? id,
    String? unitId,
    String? subjectId,
    String? title,
    int? order,
    int? durationMinutes,
    String? thumbnailAsset,
    bool? isCompleted,
  }) {
    return LessonModel(
      id: id ?? this.id,
      unitId: unitId ?? this.unitId,
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      order: order ?? this.order,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      thumbnailAsset: thumbnailAsset ?? this.thumbnailAsset,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return "LessonModel(id: $id, unitId: $unitId, subjectId: $subjectId, title:"
        " $title, order: $order, durationMinutes: $durationMinutes, "
        "thumbnailAsset: $thumbnailAsset, isCompleted: $isCompleted)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LessonModel &&
        other.id == id &&
        other.unitId == unitId &&
        other.subjectId == subjectId &&
        other.title == title &&
        other.order == order &&
        other.durationMinutes == durationMinutes &&
        other.thumbnailAsset == thumbnailAsset &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        unitId.hashCode ^
        subjectId.hashCode ^
        title.hashCode ^
        order.hashCode ^
        durationMinutes.hashCode ^
        thumbnailAsset.hashCode ^
        isCompleted.hashCode;
  }
}
