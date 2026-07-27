import "../../domain/entities/student.dart";

class StudentModel {

  const StudentModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.school,
    required this.gradeLevel,
    required this.avatarAsset,
    required this.totalPoints,
    required this.completedQuizzesCount,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map["id"] as String? ?? "",
      fullName: map["fullName"] as String? ?? "",
      email: map["email"] as String? ?? "",
      phone: map["phone"] as String? ?? "",
      school: map["school"] as String? ?? "",
      gradeLevel: map["gradeLevel"] as String? ?? "",
      avatarAsset: map["avatarAsset"] as String? ?? "",
      totalPoints: (map["totalPoints"] as num?)?.toInt() ?? 0,
      completedQuizzesCount:
          (map["completedQuizzesCount"] as num?)?.toInt() ?? 0,
    );
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      StudentModel.fromMap(json);

  factory StudentModel.fromEntity(Student s) => StudentModel(
        id: s.id,
        fullName: s.fullName,
        email: s.email,
        phone: s.phone,
        school: s.school,
        gradeLevel: s.gradeLevel,
        avatarAsset: s.avatarAsset,
        totalPoints: s.totalPoints,
        completedQuizzesCount: s.completedQuizzesCount,
      );
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String school;
  final String gradeLevel;
  final String avatarAsset;
  final int totalPoints;
  final int completedQuizzesCount;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "fullName": fullName,
      "email": email,
      "phone": phone,
      "school": school,
      "gradeLevel": gradeLevel,
      "avatarAsset": avatarAsset,
      "totalPoints": totalPoints,
      "completedQuizzesCount": completedQuizzesCount,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  Student toEntity() => Student(
        id: id,
        fullName: fullName,
        email: email,
        phone: phone,
        school: school,
        gradeLevel: gradeLevel,
        avatarAsset: avatarAsset,
        totalPoints: totalPoints,
        completedQuizzesCount: completedQuizzesCount,
      );

  StudentModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? school,
    String? gradeLevel,
    String? avatarAsset,
    int? totalPoints,
    int? completedQuizzesCount,
  }) {
    return StudentModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      school: school ?? this.school,
      gradeLevel: gradeLevel ?? this.gradeLevel,
      avatarAsset: avatarAsset ?? this.avatarAsset,
      totalPoints: totalPoints ?? this.totalPoints,
      completedQuizzesCount:
          completedQuizzesCount ?? this.completedQuizzesCount,
    );
  }

  @override
  String toString() {
    return "StudentModel(id: $id, fullName: $fullName, email: $email, "
        "phone: $phone, school: $school, gradeLevel: $gradeLevel, "
        "avatarAsset: $avatarAsset, totalPoints: $totalPoints, "
        "completedQuizzesCount: $completedQuizzesCount)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentModel &&
        other.id == id &&
        other.fullName == fullName &&
        other.email == email &&
        other.phone == phone &&
        other.school == school &&
        other.gradeLevel == gradeLevel &&
        other.avatarAsset == avatarAsset &&
        other.totalPoints == totalPoints &&
        other.completedQuizzesCount == completedQuizzesCount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        school.hashCode ^
        gradeLevel.hashCode ^
        avatarAsset.hashCode ^
        totalPoints.hashCode ^
        completedQuizzesCount.hashCode;
  }
}
