/// Une leçon de cours (contenu lu, pas un quiz) rattachée à une unité.
class Lesson {
  const Lesson({
    required this.id,
    required this.unitId,
    required this.subjectId,
    required this.title,
    required this.order,
    required this.durationMinutes,
    required this.thumbnailAsset,
    this.isCompleted = false,
  });

  final String id;
  final String unitId;
  final String subjectId;
  final String title;
  final int order;
  final int durationMinutes;
  final String thumbnailAsset;
  final bool isCompleted;

  Lesson copyWith({bool? isCompleted}) => Lesson(
        id: id,
        unitId: unitId,
        subjectId: subjectId,
        title: title,
        order: order,
        durationMinutes: durationMinutes,
        thumbnailAsset: thumbnailAsset,
        isCompleted: isCompleted ?? this.isCompleted,
      );

  @override
  bool operator ==(Object other) => other is Lesson && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
