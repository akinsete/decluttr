import 'package:decluttr/features/shared/data/repositories/streak_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('StreakRepositoryImpl', () {
    late SharedPreferences prefs;
    late StreakRepositoryImpl repo;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      repo = StreakRepositoryImpl(prefs);
    });

    test('recordActivity starts streak at 1 on first activity', () async {
      await repo.recordActivity();

      expect(await repo.currentStreak(), 1);
      expect(await repo.longestStreak(), 1);
      expect(await repo.weekActivity().then((days) => days.where((d) => d).length), 1);
    });

    test('recordActivity increments streak on consecutive days', () async {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      SharedPreferences.setMockInitialValues({
        'current_streak': 3,
        'longest_streak': 3,
        'last_activity_date': DateTime(yesterday.year, yesterday.month, yesterday.day).toIso8601String(),
      });
      prefs = await SharedPreferences.getInstance();
      repo = StreakRepositoryImpl(prefs);

      await repo.recordActivity();

      expect(await repo.currentStreak(), 4);
      expect(await repo.longestStreak(), 4);
    });

    test('recordActivity resets streak after a gap', () async {
      final threeDaysAgo = DateTime.now().subtract(const Duration(days: 3));
      SharedPreferences.setMockInitialValues({
        'current_streak': 8,
        'longest_streak': 8,
        'last_activity_date': DateTime(threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day).toIso8601String(),
      });
      prefs = await SharedPreferences.getInstance();
      repo = StreakRepositoryImpl(prefs);

      await repo.recordActivity();

      expect(await repo.currentStreak(), 1);
      expect(await repo.longestStreak(), 8);
    });

    test('recordActivity does not increment streak twice on same day', () async {
      await repo.recordActivity();
      await repo.recordActivity();

      expect(await repo.currentStreak(), 1);
      final week = await repo.weekActivity();
      expect(week.where((day) => day).length, 1);
    });

    test('heatmap reflects daily swipe counts capped at 5', () async {
      for (var i = 0; i < 7; i++) {
        await repo.recordActivity();
      }

      final heatmap = await repo.lastFiveWeeksHeatmap();
      final todayIndex = DateTime.now().weekday - DateTime.monday;
      final startMonday = DateTime.now()
          .subtract(Duration(days: DateTime.now().weekday - DateTime.monday))
          .subtract(const Duration(days: 28));
      final todayOffset = DateTime.now().difference(
        DateTime(startMonday.year, startMonday.month, startMonday.day),
      ).inDays;

      expect(heatmap[todayOffset], 5);
      expect(heatmap.where((level) => level > 0).length, 1);
      expect(todayIndex >= 0 && todayIndex < 7, isTrue);
    });

    test('currentStreak defaults to 0 when unset', () async {
      expect(await repo.currentStreak(), 0);
    });
  });
}
