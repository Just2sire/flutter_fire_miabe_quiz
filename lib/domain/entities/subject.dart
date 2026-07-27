/// Une matière/catégorie (ex: Mathématiques, Chimie, Anglais).
///
/// `progress` est une valeur cache (0.0 à 1.0) recalculée par le domaine
/// à partir des tentatives de l'étudiant ; elle sert d'affichage rapide
/// avant recalcul complet.
class Subject {
  const Subject({
    required this.id,
    required this.name,
    required this.description,
    required this.iconName,
    required this.colorHex,
    required this.totalLessons,
    required this.totalQuizzes,
    this.progress = 0.0,
  });

  final String id;
  final String name;
  final String description;
  final String iconName;
  final String colorHex;
  final int totalLessons;
  final int totalQuizzes;
  final double progress;

  Subject copyWith({double? progress}) => Subject(
    id: id,
    name: name,
    description: description,
    iconName: iconName,
    colorHex: colorHex,
    totalLessons: totalLessons,
    totalQuizzes: totalQuizzes,
    progress: progress ?? this.progress,
  );

  @override
  bool operator ==(Object other) => other is Subject && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
