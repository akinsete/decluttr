import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/error/result.dart';

class HomeScreenVm {
  const HomeScreenVm({
    required this.isFirstVisit,
    required this.streakDays,
    required this.contactsCount,
    required this.photosCount,
    required this.progress,
    required this.kept,
    required this.deleted,
    required this.isLoading,
  });

  final bool isFirstVisit;
  final int streakDays;
  final int contactsCount;
  final int photosCount;
  final double progress;
  final int kept;
  final int deleted;
  final bool isLoading;
}

class HomeScreenVmNotifier extends AsyncNotifier<HomeScreenVm> {
  @override
  Future<HomeScreenVm> build() async {
    final appState = ref.watch(appStateProvider);
    final streak = await ref.read(streakRepositoryProvider).currentStreak();

    final contacts = appState.contactsGranted
        ? await ref.read(contactsRepositoryProvider).fetchBatches()
        : null;
    final photos = appState.photosGranted
        ? await ref.read(photosRepositoryProvider).fetchBatches()
        : null;

    final contactsCount =
        contacts?.valueOrNull?.fold<int>(0, (sum, b) => sum + b.count) ?? 0;
    final photosCount =
        photos?.valueOrNull?.fold<int>(0, (sum, b) => sum + b.count) ?? 0;

    return HomeScreenVm(
      isFirstVisit: !appState.hasActivity,
      streakDays: streak,
      contactsCount: contactsCount,
      photosCount: photosCount,
      progress: 0.42,
      kept: 128,
      deleted: 64,
      isLoading: appState.isLoading,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await build());
  }
}

final homeScreenVmProvider =
    AsyncNotifierProvider<HomeScreenVmNotifier, HomeScreenVm>(
  HomeScreenVmNotifier.new,
);
