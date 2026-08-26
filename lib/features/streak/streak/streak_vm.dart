class StreakVm {
  const StreakVm({
    required this.currentStreak,
    required this.longestStreak,
    required this.itemsCleaned,
    required this.weekActivity,
    required this.heatmap,
    required this.todayWeekdayIndex,
    required this.heatmapTodayIndex,
  });

  final int currentStreak;
  final int longestStreak;
  final int itemsCleaned;
  final List<bool> weekActivity;
  final List<int> heatmap;
  final int todayWeekdayIndex;
  final int heatmapTodayIndex;
}
