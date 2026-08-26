import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/streak_repository.dart';

class StreakRepositoryImpl implements StreakRepository {
  StreakRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const _streakKey = 'current_streak';
  static const _longestStreakKey = 'longest_streak';
  static const _lastActivityKey = 'last_activity_date';
  static const _activityLogKey = 'activity_log';
  static const _heatmapDays = 35;

  @override
  Future<int> currentStreak() async => _prefs.getInt(_streakKey) ?? 0;

  @override
  Future<int> longestStreak() async => _prefs.getInt(_longestStreakKey) ?? 0;

  @override
  Future<List<bool>> weekActivity() async {
    final log = _readLog();
    final monday = _mondayOfWeek(DateTime.now());
    return List.generate(7, (index) {
      final day = monday.add(Duration(days: index));
      return _countForDate(log, day) > 0;
    });
  }

  @override
  Future<List<int>> lastFiveWeeksHeatmap() async {
    final log = _readLog();
    final startMonday = _heatmapStartMonday(DateTime.now());
    return List.generate(_heatmapDays, (index) {
      final date = startMonday.add(Duration(days: index));
      return _countForDate(log, date).clamp(0, 5);
    });
  }

  @override
  Future<void> recordActivity() async {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final lastRaw = _prefs.getString(_lastActivityKey);
    var streak = _prefs.getInt(_streakKey) ?? 0;

    if (lastRaw != null) {
      final last = DateTime.tryParse(lastRaw);
      if (last != null) {
        final lastDate = DateTime(last.year, last.month, last.day);
        final diff = todayDate.difference(lastDate).inDays;
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

    final log = _readLog();
    final key = _dateKey(todayDate);
    log[key] = (log[key] ?? 0) + 1;
    await _writeLog(log);

    await _prefs.setInt(_streakKey, streak);
    await _prefs.setString(_lastActivityKey, todayDate.toIso8601String());

    final longest = _prefs.getInt(_longestStreakKey) ?? 0;
    if (streak > longest) {
      await _prefs.setInt(_longestStreakKey, streak);
    }
  }

  Map<String, int> _readLog() {
    final raw = _prefs.getString(_activityLogKey);
    if (raw == null) {
      return {};
    }
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return decoded.map((key, value) => MapEntry(key, value as int));
    } catch (_) {
      return {};
    }
  }

  Future<void> _writeLog(Map<String, int> log) async {
    final cutoff = DateTime.now().subtract(const Duration(days: _heatmapDays));
    final pruned = <String, int>{};
    for (final entry in log.entries) {
      final date = _parseDateKey(entry.key);
      if (date == null) {
        continue;
      }
      if (!date.isBefore(DateTime(cutoff.year, cutoff.month, cutoff.day))) {
        pruned[entry.key] = entry.value;
      }
    }
    await _prefs.setString(_activityLogKey, jsonEncode(pruned));
  }

  static int _countForDate(Map<String, int> log, DateTime date) {
    return log[_dateKey(date)] ?? 0;
  }

  static String _dateKey(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  static DateTime? _parseDateKey(String key) {
    final parts = key.split('-');
    if (parts.length != 3) {
      return null;
    }
    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final day = int.tryParse(parts[2]);
    if (year == null || month == null || day == null) {
      return null;
    }
    return DateTime(year, month, day);
  }

  static DateTime _mondayOfWeek(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    return normalized.subtract(Duration(days: normalized.weekday - DateTime.monday));
  }

  static DateTime _heatmapStartMonday(DateTime date) {
    return _mondayOfWeek(date).subtract(const Duration(days: 28));
  }
}
