/// Aggregated stats for the Insights dashboard.
class InsightsSnapshot {
  const InsightsSnapshot({
    this.totalKept = 0,
    this.totalDeleted = 0,
    this.committedDeletedBytes = 0,
    this.photosDeleted = 0,
    this.contactsDeleted = 0,
    this.weekCleanedCounts = const [0, 0, 0, 0, 0, 0, 0],
  });

  final int totalKept;
  final int totalDeleted;
  final int committedDeletedBytes;
  final int photosDeleted;
  final int contactsDeleted;
  final List<int> weekCleanedCounts;

  int get weekCleanedTotal =>
      weekCleanedCounts.fold<int>(0, (sum, count) => sum + count);
}
