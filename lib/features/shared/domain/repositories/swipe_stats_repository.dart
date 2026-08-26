import '../entities/insights_snapshot.dart';
import '../entities/lifetime_swipe_stats.dart';
import '../entities/swipe_session_record.dart';

abstract class SwipeStatsRepository {
  Future<LifetimeSwipeStats> getLifetimeStats();

  Future<InsightsSnapshot> getInsightsSnapshot();

  /// Persists session locally and attempts one batched remote sync.
  Future<void> recordSession(SwipeSessionRecord session);

  /// Records bytes removed from the device library after Trash delete forever.
  Future<void> recordCommittedDeletedBytes(int bytes);

  /// Retries any sessions that failed to upload.
  Future<void> syncPendingSessions();
}
