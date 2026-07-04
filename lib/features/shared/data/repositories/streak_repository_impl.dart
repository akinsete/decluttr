import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/streak_repository.dart';

class StreakRepositoryImpl implements StreakRepository {
  StreakRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const _streakKey = 'current_streak';
  static const _lastActivityKey = 'last_activity_date';

  @override
  Future<int> currentStreak() async => _prefs.getInt(_streakKey) ?? 4;

  @override
  Future<List<bool>> weekActivity() async {
    return const [true, true, true, true, false, false, false];
  }

  @override
  Future<List<int>> lastFiveWeeksHeatmap() async {
    return const [2, 4, 1, 5, 3, 0, 2, 4, 3, 1, 5, 2, 4, 3, 2, 1, 4, 5, 3, 2, 1, 0, 3, 4, 2, 5, 3, 1, 4, 2, 3, 5, 1, 2, 4];
  }

  @override
  Future<void> recordActivity() async {
    final today = DateTime.now();
    final lastRaw = _prefs.getString(_lastActivityKey);
    var streak = _prefs.getInt(_streakKey) ?? 0;

    if (lastRaw != null) {
      final last = DateTime.tryParse(lastRaw);
      if (last != null) {
        final diff = today.difference(last).inDays;
        if (diff == 1) {
          streak += 1;
        } else if (diff > 1) {
          streak = 1;
        }
      } else {
        streak = 1;
      }
    } else {
      streak = 1;
    }

    await _prefs.setInt(_streakKey, streak);
    await _prefs.setString(_lastActivityKey, today.toIso8601String());
  }
}
