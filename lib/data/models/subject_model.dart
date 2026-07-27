import "../../domain/entities/subject.dart";

/// DTO de sérialisation JSON. Ne fuit jamais vers la couche domaine :
/// on convertit toujours via [toEntity] avant de remonter dans les
/// use cases / providers.
class SubjectModel {

  const SubjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.iconName,
    required this.colorHex,
    required this.totalLessons,
    required this.totalQuizzes,
    required this.progress,
  });

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      id: map["id"] as String? ?? "",
      name: map["name"] as String? ?? "",
      description: map["description"] as String? ?? "",
      iconName: map["iconName"] as String? ?? "",
      colorHex: map["colorHex"] as String? ?? "",
      totalLessons: (map["totalLessons"] as num?)?.toInt() ?? 0,
      totalQuizzes: (map["totalQuizzes"] as num?)?.toInt() ?? 0,
      progress: (map["progress"] as num?)?.toDouble() ?? 0.0,
    );
  }

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      SubjectModel.fromMap(json);

  factory SubjectModel.fromEntity(Subject subject) => SubjectModel(
        id: subject.id,
        name: subject.name,
        description: subject.description,
        iconName: subject.iconName,
        colorHex: subject.colorHex,
        totalLessons: subject.totalLessons,
        totalQuizzes: subject.totalQuizzes,
        progress: subject.progress,
      );
  final String id;
  final String name;
  final String description;
  final String iconName;
  final String colorHex;
  final int totalLessons;
  final int totalQuizzes;
  final double progress;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "iconName": iconName,
      "colorHex": colorHex,
      "totalLessons": totalLessons,
      "totalQuizzes": totalQuizzes,
      "progress": progress,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  Subject toEntity() => Subject(
        id: id,
        name: name,
        description: description,
        iconName: iconName,
        colorHex: colorHex,
        totalLessons: totalLessons,
        totalQuizzes: totalQuizzes,
        progress: progress,
      );

  SubjectModel copyWith({
    String? id,
    String? name,
    String? description,
    String? iconName,
    String? colorHex,
    int? totalLessons,
    int? totalQuizzes,
    double? progress,
  }) {
    return SubjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
      totalLessons: totalLessons ?? this.totalLessons,
      totalQuizzes: totalQuizzes ?? this.totalQuizzes,
      progress: progress ?? this.progress,
    );
  }

  @override
  String toString() {
    return "SubjectModel(id: $id, name: $name, description: $description,"
    " iconName: $iconName, colorHex: $colorHex, totalLessons: $totalLessons, "
    "totalQuizzes: $totalQuizzes, progress: $progress)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubjectModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.iconName == iconName &&
        other.colorHex == colorHex &&
        other.totalLessons == totalLessons &&
        other.totalQuizzes == totalQuizzes &&
        other.progress == progress;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        iconName.hashCode ^
        colorHex.hashCode ^
        totalLessons.hashCode ^
        totalQuizzes.hashCode ^
        progress.hashCode;
  }
}
