import "enums.dart";
import "question.dart";

/// Un quiz classique (non chronométré à l'échelle globale) rattaché à une
/// matière et, optionnellement, une unité. Référence une sélection de
/// questions par id, piochées dans la banque [Question].
class Quiz {
  const Quiz({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.questionIds,
    this.unitId,
    this.status = QuizStatus.notStarted,
    this.progress = 0.0,
  });

  final String id;
  final String subjectId;
  final String? unitId;
  final String title;
  final List<String> questionIds;
  final QuizStatus status;
  final double progress;

  int get totalQuestions => questionIds.length;

  Quiz copyWith({QuizStatus? status, double? progress}) => Quiz(
        id: id,
        subjectId: subjectId,
        unitId: unitId,
        title: title,
        questionIds: questionIds,
        status: status ?? this.status,
        progress: progress ?? this.progress,
      );

  @override
  bool operator ==(Object other) => other is Quiz && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
