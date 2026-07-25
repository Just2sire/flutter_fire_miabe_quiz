import "dart:convert";
import "package:flutter/services.dart" show rootBundle;

/// Charge les fichiers JSON packagés dans `assets/data/` et les garde en
/// cache mémoire pour éviter de relire le disque à chaque appel de
/// repository. Un seul point d'accès pour toute la couche data.
class LocalJsonDataSource {
  LocalJsonDataSource._internal();

  static final LocalJsonDataSource instance = LocalJsonDataSource._internal();

  final Map<String, dynamic> _cache = {};

  Future<List<Map<String, dynamic>>> loadList(String assetFileName) async {
    if (_cache.containsKey(assetFileName)) {
      return (_cache[assetFileName] as List).cast<Map<String, dynamic>>();
    }
    final raw = await rootBundle.loadString("assets/data/$assetFileName");
    final decoded = jsonDecode(raw) as List;
    final list = decoded.cast<Map<String, dynamic>>();
    _cache[assetFileName] = list;
    return list;
  }

  Future<Map<String, dynamic>> loadObject(String assetFileName) async {
    if (_cache.containsKey(assetFileName)) {
      return _cache[assetFileName] as Map<String, dynamic>;
    }
    final raw = await rootBundle.loadString("assets/data/$assetFileName");
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    _cache[assetFileName] = decoded;
    return decoded;
  }

  /// Utile pour les tests ou un "pull-to-refresh" qui doit relire le disque.
  void clearCache() => _cache.clear();
}
