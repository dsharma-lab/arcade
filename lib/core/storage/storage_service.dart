/// StorageService — read/write high scores using Hive.
///
/// All Hive access in the app must go through this service.
import 'package:hive_flutter/hive_flutter.dart';

const _kScoresBox = 'high_scores';

class StorageService {
  StorageService._();

  static final StorageService instance = StorageService._();

  /// Returns the stored high score for [gameId], defaulting to 0.
  Future<int> getHighScore(String gameId) async {
    final box = await Hive.openBox<int>(_kScoresBox);
    return box.get(gameId, defaultValue: 0)!;
  }

  /// Saves [score] for [gameId] only if it exceeds the current high score.
  Future<void> saveHighScore(String gameId, int score) async {
    final box = await Hive.openBox<int>(_kScoresBox);
    final current = box.get(gameId, defaultValue: 0)!;
    if (score > current) {
      await box.put(gameId, score);
    }
  }

  /// Clears all high scores (used in tests or settings reset).
  Future<void> clearAll() async {
    final box = await Hive.openBox<int>(_kScoresBox);
    await box.clear();
  }
}
