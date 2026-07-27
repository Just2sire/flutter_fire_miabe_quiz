import "package:flutter/material.dart";
import "package:miabe_quiz/domain/entities/index.dart"
    show Student, QuizAttempt;
import "../../domain/repositories/student_repository.dart";

class StudentProvider extends ChangeNotifier {
  StudentProvider(this._repository);
  final StudentRepository _repository;

  Student? _student;
  Student? get student => _student;

  List<QuizAttempt> _history = [];
  List<QuizAttempt> get history => _history;

  double get averageScore {
    final completed = _history.where((a) => a.isCompleted).toList();
    if (completed.isEmpty) return 0;
    final total = completed.fold<double>(0, (sum, a) => sum + a.percentage);
    return total / completed.length;
  }

  Future<void> load() async {
    _student = await _repository.getCurrentStudent();
    _history = await _repository.getAttemptHistory(_student!.id);
    notifyListeners();
  }

  Future<void> updateProfile({
    String? fullName,
    String? email,
    String? phone,
    String? school,
  }) async {
    if (_student == null) return;
    final updated = _student!.copyWith(
      fullName: fullName,
      email: email,
      phone: phone,
      school: school,
    );
    await _repository.updateStudent(updated);
    _student = updated;
    notifyListeners();
  }

  Future<void> resetAllData() async {
    await _repository.resetAllData();
    await load();
  }
}
