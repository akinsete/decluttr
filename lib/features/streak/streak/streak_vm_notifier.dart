import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';

class StreakVm {
  const StreakVm({
    required this.currentStreak,
    required this.weekActivity,
    required this.heatmap,
  });

  final int currentStreak;
  final List<bool> weekActivity;
  final List<int> heatmap;
}

class StreakVmNotifier extends AsyncNotifier<StreakVm> {
  @override
  Future<StreakVm> build() async {
    final repo = ref.read(streakRepositoryProvider);
    return StreakVm(
      currentStreak: await repo.currentStreak(),
      weekActivity: await repo.weekActivity(),
      heatmap: await repo.lastFiveWeeksHeatmap(),
    );
  }
}

final streakVmProvider = AsyncNotifierProvider<StreakVmNotifier, StreakVm>(
  StreakVmNotifier.new,
);
