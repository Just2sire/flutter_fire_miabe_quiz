import "box.dart";
import "enums.dart";
import "quiz.dart";

/// Une question de la banque, rattachée à une matière et un niveau de
/// difficulté. Les [Quiz] et [Box] ne stockent que des `questionIds` :
/// la question elle-même vit une seule fois dans la banque.
class Question {
  const Question({
    required this.id,
    required this.subjectId,
    required this.difficulty,
    required this.text,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
    required this.points,
  });

  final String id;
  final String subjectId;
  final Difficulty difficulty;
  final String text;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;
  final int points;

  bool isCorrect(int chosenIndex) => chosenIndex == correctOptionIndex;

  @override
  bool operator ==(Object other) => other is Question && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
