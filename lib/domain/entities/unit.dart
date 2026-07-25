/// Une unité pédagogique regroupant plusieurs leçons au sein d'une matière
/// (ex: "Unit 1" sous "Math").
class Unit {
  const Unit({
    required this.id,
    required this.subjectId,
    required this.name,
    required this.order,
  });

  final String id;
  final String subjectId;
  final String name;
  final int order;

  @override
  bool operator ==(Object other) => other is Unit && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
