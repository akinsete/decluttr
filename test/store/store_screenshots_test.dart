import 'dart:io';

import 'package:decluttr/core/di/app_state.dart';
import 'package:decluttr/core/di/providers.dart';
import 'package:decluttr/core/di/trash_dock_badge_providers.dart';
import 'package:decluttr/features/home/home/home_page.dart';
import 'package:decluttr/features/home/home/home_vm_notifier.dart';
import 'package:decluttr/features/settings/settings/settings_notifier.dart';
import 'package:decluttr/features/settings/settings/settings_page.dart';
import 'package:decluttr/features/settings/settings/settings_state.dart';
import 'package:decluttr/features/trash/trash/trash_notifier.dart';
import 'package:decluttr/features/trash/trash/trash_page.dart';
import 'package:decluttr/features/trash/trash/trash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

/// Decluttr store listing captures (light theme for brand consistency).
const Size _storePhoneSize = Size(390, 844);

Future<void> _capture(
  WidgetTester tester, {
  required String storeFolder,
  required String fileName,
  required Widget child,
  List<Override> overrides = const [],
}) async {
  final prefs = await initTestPrefs({
    'onboarding_complete': true,
    'tutorial_seen': true,
    'has_activity': true,
  });

  await tester.binding.setSurfaceSize(_storePhoneSize);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    buildTestApp(
      prefs: prefs,
      brightness: Brightness.light,
      overrides: overrides,
      child: MediaQuery(
        data: const MediaQueryData(size: _storePhoneSize),
        child: child,
      ),
    ),
  );
  await pumpCaptureFrames(tester);

  final dir = Directory('test/store/goldens/$storeFolder');
  await dir.create(recursive: true);
  await expectLater(
    find.byType(MaterialApp),
    matchesGoldenFile('goldens/$storeFolder/$fileName'),
  );
}

void main() {
  for (final store in ['google-play', 'app-store']) {
    group('$store screenshots', () {
      testWidgets('01-home_light.png', (tester) async {
        await _capture(
          tester,
          storeFolder: store,
          fileName: '01-home_light.png',
          overrides: [
            appStateProvider.overrideWith(_StoreAppState.new),
            homeScreenVmProvider.overrideWith(_StoreHomeVm.new),
            trashItemCountProvider.overrideWith((ref) async => 0),
          ],
          child: const HomePage(),
        );
      }, tags: 'store-screenshot');

      testWidgets('02-trash_light.png', (tester) async {
        await _capture(
          tester,
          storeFolder: store,
          fileName: '02-trash_light.png',
          overrides: [
            trashUiProvider.overrideWith(_StoreTrashUi.new),
          ],
          child: const TrashPage(),
        );
      }, tags: 'store-screenshot');

      testWidgets('03-settings_light.png', (tester) async {
        await _capture(
          tester,
          storeFolder: store,
          fileName: '03-settings_light.png',
          overrides: [
            appStateProvider.overrideWith(_StoreAppState.new),
            settingsUiProvider.overrideWith(_StoreSettingsUi.new),
          ],
          child: const SettingsPage(),
        );
      }, tags: 'store-screenshot');
    });
  }
}

class _StoreAppState extends AppStateNotifier {
  @override
  AppState build() => const AppState(
        isLoading: false,
        onboardingComplete: true,
        hasActivity: true,
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
      itemsRemaining: 42,
      progress: 0.42,
      kept: 120,
      deleted: 30,
      isLoading: false,
    );
  }
}

class _StoreTrashUi extends TrashUiNotifier {
  @override
  TrashUiState build() => const TrashUiState(isLoading: false);
}

class _StoreSettingsUi extends SettingsUiNotifier {
  @override
  SettingsUiState build() => const SettingsUiState();
}
