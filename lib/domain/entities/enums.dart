/// Niveau de difficulté d'une question ou d'un quiz.
enum Difficulty { easy, medium, hard }

/// État d'avancement d'un quiz pour un étudiant donné.
enum QuizStatus { notStarted, inProgress, completed }

/// État d'ouverture d'une Box (défi à durée limitée).
enum BoxStatus { open, closed }

/// Origine d'une tentative : un Quiz classique ou une Box chronométrée.
enum AttemptSourceType { quiz, box }

extension DifficultyX on Difficulty {
  String get label => switch (this) {
    Difficulty.easy => "Facile",
    Difficulty.medium => "Moyen",
    Difficulty.hard => "Difficile",
  };
}

extension QuizStatusX on QuizStatus {
  String get label => switch (this) {
    QuizStatus.notStarted => "Non commencé",
    QuizStatus.inProgress => "En cours",
    QuizStatus.completed => "Terminé",
  };
}
