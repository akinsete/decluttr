abstract class StreakRepository {
  Future<int> currentStreak();
  Future<List<bool>> weekActivity();
  Future<List<int>> lastFiveWeeksHeatmap();
  Future<void> recordActivity();
}
