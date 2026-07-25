import "../../domain/entities/unit.dart";

class UnitModel {
  final String id;
  final String subjectId;
  final String name;
  final int order;

  const UnitModel({
    required this.id,
    required this.subjectId,
    required this.name,
    required this.order,
  });

  factory UnitModel.fromMap(Map<String, dynamic> map) {
    return UnitModel(
      id: map['id'] as String? ?? '',
      subjectId: map['subjectId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      order: (map['order'] as num?)?.toInt() ?? 0,
    );
  }

  factory UnitModel.fromJson(Map<String, dynamic> json) =>
      UnitModel.fromMap(json);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subjectId': subjectId,
      'name': name,
      'order': order,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  factory UnitModel.fromEntity(Unit unit) => UnitModel(
        id: unit.id,
        subjectId: unit.subjectId,
        name: unit.name,
        order: unit.order,
      );

  Unit toEntity() =>
      Unit(id: id, subjectId: subjectId, name: name, order: order);

  UnitModel copyWith({
    String? id,
    String? subjectId,
    String? name,
    int? order,
  }) {
    return UnitModel(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      name: name ?? this.name,
      order: order ?? this.order,
    );
  }

  @override
  String toString() {
    return 'UnitModel(id: $id, subjectId: $subjectId, name: $name, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UnitModel &&
        other.id == id &&
        other.subjectId == subjectId &&
        other.name == name &&
        other.order == order;
  }

  @override
  int get hashCode {
    return id.hashCode ^ subjectId.hashCode ^ name.hashCode ^ order.hashCode;
  }
}
