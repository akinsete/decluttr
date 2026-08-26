abstract class StreakRepository {
  Future<int> currentStreak();
  Future<int> longestStreak();
  Future<List<bool>> weekActivity();
  Future<List<int>> lastFiveWeeksHeatmap();
  Future<void> recordActivity();
}
