import 'package:decluttr/core/di/providers.dart';
import 'package:decluttr/features/insights/insights/insights_vm_notifier.dart';
import 'package:decluttr/features/shared/domain/entities/insights_snapshot.dart';
import 'package:decluttr/features/shared/domain/entities/lifetime_swipe_stats.dart';
import 'package:decluttr/features/shared/domain/entities/swipe_session_record.dart';
import 'package:decluttr/features/shared/domain/repositories/streak_repository.dart';
import 'package:decluttr/features/shared/domain/repositories/swipe_stats_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('build maps snapshot and streak values into InsightsVm', () async {
    final container = ProviderContainer(
      overrides: [
        swipeStatsRepositoryProvider.overrideWithValue(_FakeSwipeStatsRepository()),
        streakRepositoryProvider.overrideWithValue(_FakeStreakRepository()),
      ],
    );
    addTearDown(container.dispose);

    final vm = await container.read(insightsVmProvider.future);

    expect(vm.totalKept, 100);
    expect(vm.totalDeleted, 50);
    expect(vm.committedDeletedBytes, 240000000);
    expect(vm.photosDeleted, 40);
    expect(vm.contactsDeleted, 10);
    expect(vm.weekCleanedCounts, [1, 2, 3, 4, 5, 6, 7]);
    expect(vm.currentStreak, 4);
    expect(vm.longestStreak, 12);
    expect(vm.todayWeekdayIndex, DateTime.now().weekday - DateTime.monday);
  });
}

class _FakeSwipeStatsRepository implements SwipeStatsRepository {
  @override
  Future<InsightsSnapshot> getInsightsSnapshot() async {
    return const InsightsSnapshot(
      totalKept: 100,
      totalDeleted: 50,
      committedDeletedBytes: 240000000,
      photosDeleted: 40,
      contactsDeleted: 10,
      weekCleanedCounts: [1, 2, 3, 4, 5, 6, 7],
    );
  }

  @override
  Future<LifetimeSwipeStats> getLifetimeStats() async => const LifetimeSwipeStats();

  @override
  Future<void> recordCommittedDeletedBytes(int bytes) async {}

  @override
  Future<void> recordSession(SwipeSessionRecord session) async {}

  @override
  Future<void> syncPendingSessions() async {}
}

class _FakeStreakRepository implements StreakRepository {
  @override
  Future<int> currentStreak() async => 4;

  @override
  Future<int> longestStreak() async => 12;

  @override
  Future<List<bool>> weekActivity() async => List.filled(7, false);

  @override
  Future<List<int>> lastFiveWeeksHeatmap() async => List.filled(35, 0);

  @override
  Future<void> recordActivity() async {}
}
