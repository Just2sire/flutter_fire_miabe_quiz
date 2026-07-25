import "enums.dart";

/// Une "Box" est un défi à durée limitée (compte à rebours affiché) qui
/// regroupe un lot de questions, potentiellement issues de plusieurs
/// matières. Correspond aux cartes "Box 1 / Box 2 / Box 3" de la maquette.
class Box {
  const Box({
    required this.id,
    required this.title,
    required this.questionIds,
    required this.closesAt,
    this.status = BoxStatus.open,
  });

  final String id;
  final String title;
  final List<String> questionIds;
  final DateTime closesAt;
  final BoxStatus status;

  int get totalQuestions => questionIds.length;

  Duration get remaining => closesAt.difference(DateTime.now());

  bool get isExpired => remaining.isNegative;

  @override
  bool operator ==(Object other) => other is Box && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
