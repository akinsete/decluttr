class InsightsVm {
  const InsightsVm({
    required this.totalKept,
    required this.totalDeleted,
    required this.committedDeletedBytes,
    required this.photosDeleted,
    required this.contactsDeleted,
    required this.weekCleanedCounts,
    required this.todayWeekdayIndex,
    required this.currentStreak,
    required this.longestStreak,
  });

  final int totalKept;
  final int totalDeleted;
  final int committedDeletedBytes;
  final int photosDeleted;
  final int contactsDeleted;
  final List<int> weekCleanedCounts;
  final int todayWeekdayIndex;
  final int currentStreak;
  final int longestStreak;

  int get weekCleanedTotal =>
      weekCleanedCounts.fold<int>(0, (sum, count) => sum + count);
}
