import "package:flutter/material.dart";
import "package:miabe_quiz/domain/entities/index.dart" show Subject, Lesson, Unit;
import "package:miabe_quiz/domain/repositories/index.dart" show SubjectRepository;

enum LoadStatus { idle, loading, loaded, error }

class SubjectsProvider extends ChangeNotifier {

  SubjectsProvider(this._repository);
  final SubjectRepository _repository;

  LoadStatus _status = LoadStatus.idle;
  LoadStatus get status => _status;

  List<Subject> _subjects = [];
  List<Subject> get subjects => _subjects;

  String _searchQuery = "";
  String get searchQuery => _searchQuery;

  List<Subject> get filteredSubjects {
    if (_searchQuery.trim().isEmpty) return _subjects;
    final q = _searchQuery.toLowerCase();
    return _subjects.where((s) => s.name.toLowerCase().contains(q)).toList();
  }

  Future<void> loadSubjects() async {
    _status = LoadStatus.loading;
    notifyListeners();
    try {
      _subjects = await _repository.getAllSubjects();
      _status = LoadStatus.loaded;
    } catch (_) {
      _status = LoadStatus.error;
    }
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<List<Unit>> unitsFor(String subjectId) =>
      _repository.getUnitsBySubject(subjectId);

  Future<List<Lesson>> lessonsForUnit(String unitId) =>
      _repository.getLessonsByUnit(unitId);

  Future<List<Lesson>> lessonsForSubject(String subjectId) =>
      _repository.getLessonsBySubject(subjectId);

  Future<void> markLessonCompleted(String lessonId) =>
      _repository.markLessonCompleted(lessonId);
}
