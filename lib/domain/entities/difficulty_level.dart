import "enums.dart";

/// Configuration associée à un [Difficulty] : temps par question et
/// multiplicateur de points. Permet d'ajuster le rythme du jeu sans
/// toucher au code (juste le JSON de seed).
class DifficultyLevel {
  const DifficultyLevel({
    required this.id,
    required this.name,
    required this.timePerQuestionSeconds,
    required this.pointsPerCorrect,
    required this.description,
  });

  final Difficulty id;
  final String name;
  final int timePerQuestionSeconds;
  final int pointsPerCorrect;
  final String description;
}
