import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import 'streak_vm.dart';

class StreakVmNotifier extends AsyncNotifier<StreakVm> {
  @override
  Future<StreakVm> build() async {
    final repo = ref.read(streakRepositoryProvider);
    final stats = await ref.read(swipeStatsRepositoryProvider).getLifetimeStats();
    final now = DateTime.now();
    final normalized = DateTime(now.year, now.month, now.day);
    final startMonday = normalized
        .subtract(Duration(days: normalized.weekday - DateTime.monday))
        .subtract(const Duration(days: 28));

    return StreakVm(
      currentStreak: await repo.currentStreak(),
      longestStreak: await repo.longestStreak(),
      itemsCleaned: stats.totalKept + stats.totalDeleted,
      weekActivity: await repo.weekActivity(),
      heatmap: await repo.lastFiveWeeksHeatmap(),
      todayWeekdayIndex: now.weekday - DateTime.monday,
      heatmapTodayIndex: normalized.difference(startMonday).inDays.clamp(0, 34),
    );
  }
}

final streakVmProvider = AsyncNotifierProvider<StreakVmNotifier, StreakVm>(
  StreakVmNotifier.new,
);
