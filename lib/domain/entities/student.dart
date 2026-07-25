import "quiz_attempt.dart";

/// Profil de l'étudiant/joueur et ses statistiques cumulées.
///
/// `totalPoints`/`completedQuizzesCount` sont des compteurs cache,
/// recalculables à partir de l'historique de [QuizAttempt] si besoin
/// de réconciliation.
class Student {
  const Student({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.school,
    required this.gradeLevel,
    required this.avatarAsset,
    this.totalPoints = 0,
    this.completedQuizzesCount = 0,
  });

  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String school;
  final String gradeLevel;
  final String avatarAsset;
  final int totalPoints;
  final int completedQuizzesCount;

  Student copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? school,
    int? totalPoints,
    int? completedQuizzesCount,
  }) =>
      Student(
        id: id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        school: school ?? this.school,
        gradeLevel: gradeLevel,
        avatarAsset: avatarAsset,
        totalPoints: totalPoints ?? this.totalPoints,
        completedQuizzesCount:
            completedQuizzesCount ?? this.completedQuizzesCount,
      );

  @override
  bool operator ==(Object other) => other is Student && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
