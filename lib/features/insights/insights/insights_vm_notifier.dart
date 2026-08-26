import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import 'insights_vm.dart';

class InsightsVmNotifier extends AsyncNotifier<InsightsVm> {
  @override
  Future<InsightsVm> build() async {
    final snapshot = await ref.read(swipeStatsRepositoryProvider).getInsightsSnapshot();
    final streakRepo = ref.read(streakRepositoryProvider);
    final now = DateTime.now();

    return InsightsVm(
      totalKept: snapshot.totalKept,
      totalDeleted: snapshot.totalDeleted,
      committedDeletedBytes: snapshot.committedDeletedBytes,
      photosDeleted: snapshot.photosDeleted,
      contactsDeleted: snapshot.contactsDeleted,
      weekCleanedCounts: snapshot.weekCleanedCounts,
      todayWeekdayIndex: now.weekday - DateTime.monday,
      currentStreak: await streakRepo.currentStreak(),
      longestStreak: await streakRepo.longestStreak(),
    );
  }
}

final insightsVmProvider = AsyncNotifierProvider<InsightsVmNotifier, InsightsVm>(
  InsightsVmNotifier.new,
);
