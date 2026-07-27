import "dart:async";
import "package:flutter/material.dart";
import "../../domain/entities/box.dart";
import "../../domain/repositories/quiz_repository.dart";

class BoxesProvider extends ChangeNotifier {
  BoxesProvider(this._repository) {
    _tickTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => notifyListeners(),
    );
  }
  final BoxRepository _repository;

  List<Box> _boxes = [];
  List<Box> get boxes => _boxes;

  late final Timer _tickTimer;

  Future<void> loadBoxes() async {
    _boxes = await _repository.getAllBoxes();
    notifyListeners();
  }

  @override
  void dispose() {
    _tickTimer.cancel();
    super.dispose();
  }
}
