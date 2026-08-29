@Tags(['store-screenshot'])
library;

import 'dart:io';

import 'package:decluttr/core/di/app_state.dart';
import 'package:decluttr/core/di/providers.dart';
import 'package:decluttr/core/di/trash_dock_badge_providers.dart';
import 'package:decluttr/features/batch/batch_photos/batch_photos_notifier.dart';
import 'package:decluttr/features/batch/batch_photos/batch_photos_page.dart';
import 'package:decluttr/features/home/home/home_page.dart';
import 'package:decluttr/features/home/home/home_vm_notifier.dart';
import 'package:decluttr/features/onboarding/splash/splash_page.dart';
import 'package:decluttr/features/shared/domain/entities/batch_item.dart';
import 'package:decluttr/features/shared/domain/entities/trash_item.dart';
import 'package:decluttr/features/trash/trash/trash_notifier.dart';
import 'package:decluttr/features/trash/trash/trash_page.dart';
import 'package:decluttr/features/trash/trash/trash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

bool get _skipPixelTestsInCi =>
    Platform.environment['CI'] == 'true' ||
    (Platform.environment['CM_BUILD_ID']?.isNotEmpty ?? false);

/// Store listing captures — run locally only (`flutter test --tags store-screenshot`).
/// Frames: splash → dashboard → deleted photos → photos directory.
const Size _storePhoneSize = Size(390, 844);

Future<void> _capture(
  WidgetTester tester, {
  required String storeFolder,
  required String fileName,
  required Widget child,
  List<Override> overrides = const [],
  Map<String, Object> prefs = const {
    'onboarding_complete': true,
    'tutorial_seen': true,
    'has_activity': true,
  },
  /// Extra time for entry animations (e.g. splash fade-in).
  Duration extraPump = Duration.zero,
}) async {
  final sharedPrefs = await initTestPrefs(prefs);

  await tester.binding.setSurfaceSize(_storePhoneSize);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    buildTestApp(
      prefs: sharedPrefs,
      brightness: Brightness.light,
      overrides: overrides,
      child: child,
    ),
  );
  await pumpCaptureFrames(tester);
  if (extraPump > Duration.zero) {
    await tester.pump(extraPump);
  }

  await expectLater(
    find.byType(MaterialApp),
    matchesGoldenFile('goldens/$storeFolder/$fileName'),
  );
}

void main() {
  if (_skipPixelTestsInCi) {
    test(
      'store screenshots skipped in CI',
      () {},
      skip: 'Run locally: flutter test --tags store-screenshot',
    );
    return;
  }

  for (final store in ['google-play', 'app-store']) {
    group('$store screenshots', () {
      testWidgets('01-splash_light.png', (tester) async {
        await _capture(
          tester,
          storeFolder: store,
          fileName: '01-splash_light.png',
          prefs: const {},
          overrides: [
            appStateProvider.overrideWith(_PendingSplashAppState.new),
          ],
          // Splash entry fade is 900ms; wait so logo/tagline are fully visible.
          extraPump: const Duration(milliseconds: 950),
          child: const SplashPage(),
        );
      }, tags: 'store-screenshot');

      testWidgets('02-home_light.png', (tester) async {
        await _capture(
          tester,
          storeFolder: store,
          fileName: '02-home_light.png',
          overrides: [
            appStateProvider.overrideWith(_StoreAppState.new),
            homeScreenVmProvider.overrideWith(_StoreHomeVm.new),
          ],
          child: const HomePage(),
        );
      }, tags: 'store-screenshot');

      testWidgets('03-trash_light.png', (tester) async {
        await _capture(
          tester,
          storeFolder: store,
          fileName: '03-trash_light.png',
          overrides: [
            trashUiProvider.overrideWith(_PopulatedTrashUi.new),
          ],
          child: const TrashPage(),
        );
      }, tags: 'store-screenshot');

      testWidgets('04-photos_light.png', (tester) async {
        await _capture(
          tester,
          storeFolder: store,
          fileName: '04-photos_light.png',
          overrides: [
            batchPhotosProvider.overrideWith(_SampleBatchPhotos.new),
            trashItemCountProvider.overrideWith((ref) async => 9),
          ],
          child: const BatchPhotosPage(),
        );
      }, tags: 'store-screenshot');
    });
  }
}

class _PendingSplashAppState extends AppStateNotifier {
  @override
  AppState build() => const AppState(isLoading: false);
}

class _StoreAppState extends AppStateNotifier {
  @override
  AppState build() => const AppState(
        isLoading: false,
        onboardingComplete: true,
        hasActivity: true,
        photosGranted: true,
        contactsGranted: true,
      );
}

class _StoreHomeVm extends HomeScreenVmNotifier {
  @override
  Future<HomeScreenVm> build() async {
    return const HomeScreenVm(
      isFirstVisit: false,
      streakDays: 4,
      contactsCount: 11,
      photosCount: 95,
      itemsRemaining: 106,
      progress: 192 / 298,
      kept: 128,
      deleted: 64,
      isLoading: false,
    );
  }
}

class _PopulatedTrashUi extends TrashUiNotifier {
  @override
  TrashUiState build() {
    return TrashUiState(
      isLoading: false,
      items: [
        for (var i = 0; i < 9; i++)
          TrashItem(
            id: 't$i',
            type: TrashItemType.photo,
            title: 'Photo $i',
            subtitle: '2.4 MB',
            deletedAt: DateTime(2024, 5, 28 - i),
            monthKey: '2024-05',
            sizeBytes: 2400000,
            gradientIndex: i % 6,
            isVideo: i == 1 || i == 4,
            durationLabel: i == 1
                ? '0:18'
                : i == 4
                    ? '0:07'
                    : null,
          ),
      ],
    );
  }

  @override
  Future<void> refresh() async {
    // Keep seeded store items; do not hit empty test repositories.
  }
}

class _SampleBatchPhotos extends BatchPhotosNotifier {
  @override
  Future<List<BatchItem>> build() async => const [
        BatchItem(
          id: 'dup',
          kind: BatchKind.photos,
          title: 'Duplicates',
          subtitle: '11 similar',
          count: 11,
          isDuplicates: true,
        ),
        BatchItem(
          id: '2026-05',
          kind: BatchKind.photos,
          title: 'May 2026',
          subtitle: '7 photos',
          count: 7,
        ),
        BatchItem(
          id: '2026-04',
          kind: BatchKind.photos,
          title: 'April 2026',
          subtitle: '6 photos',
          count: 6,
          gradientIndex: 1,
        ),
        BatchItem(
          id: '2026-03',
          kind: BatchKind.photos,
          title: 'March 2026',
          subtitle: '7 photos',
          count: 7,
          gradientIndex: 2,
        ),
      ];
}
