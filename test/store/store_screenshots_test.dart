import 'dart:io';

import 'package:decluttr/features/home/home/home_page.dart';
import 'package:decluttr/features/settings/settings/settings_page.dart';
import 'package:decluttr/features/trash/trash/trash_page.dart';
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
      child: MediaQuery(
        data: const MediaQueryData(size: _storePhoneSize),
        child: child,
      ),
    ),
  );
  await tester.pumpAndSettle();

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
          child: const HomePage(),
        );
      }, tags: 'store-screenshot');

      testWidgets('02-trash_light.png', (tester) async {
        await _capture(
          tester,
          storeFolder: store,
          fileName: '02-trash_light.png',
          child: const TrashPage(),
        );
      }, tags: 'store-screenshot');

      testWidgets('03-settings_light.png', (tester) async {
        await _capture(
          tester,
          storeFolder: store,
          fileName: '03-settings_light.png',
          child: const SettingsPage(),
        );
      }, tags: 'store-screenshot');
    });
  }
}
