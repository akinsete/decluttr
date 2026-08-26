import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: implementation_imports
import 'package:riverpod/src/framework.dart' show Override;

import 'package:decluttr/app/router/app_router.dart';
import 'package:decluttr/app/router/app_router_provider.dart';
import 'package:decluttr/core/di/providers.dart';
import 'package:decluttr/core/theme/app_theme.dart';
import 'package:decluttr/l10n/generated/app_localizations.dart';

export 'package:riverpod/src/framework.dart' show Override;

enum GoldenThemeVariant { lightOnly, darkOnly, both }

Future<SharedPreferences> initTestPrefs([Map<String, Object> values = const {}]) async {
  SharedPreferences.setMockInitialValues(values);
  return SharedPreferences.getInstance();
}

Widget buildTestApp({
  required Widget child,
  required SharedPreferences prefs,
  List<Override> overrides = const [],
  Locale locale = const Locale('en'),
  Brightness brightness = Brightness.light,
}) {
  final theme = buildLightTheme();
  final darkTheme = buildDarkTheme();

  return ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      ...overrides,
    ],
    child: MaterialApp(
      theme: theme,
      darkTheme: darkTheme,
      themeMode: brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );
}

Widget buildTestRouterApp({
  required SharedPreferences prefs,
  List<Override> overrides = const [],
  Locale locale = const Locale('en'),
  AppRouter? appRouter,
  Brightness brightness = Brightness.light,
}) {
  final router = appRouter ?? AppRouter();

  return ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      appRouterProvider.overrideWithValue(router),
      ...overrides,
    ],
    child: MaterialApp.router(
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router.config(),
    ),
  );
}

Future<void> runThemedGolden(
  WidgetTester tester, {
  required String baseName,
  required Widget Function(Brightness brightness) builder,
  required SharedPreferences prefs,
  List<Override> overrides = const [],
  GoldenThemeVariant variant = GoldenThemeVariant.both,
  bool settle = true,
}) async {
  const logicalWidth = 390.0;
  const baselineHeight = 844.0;
  const baselineSize = Size(logicalWidth, baselineHeight);

  Future<void> snap(Brightness brightness, String suffix) async {
    await tester.binding.setSurfaceSize(baselineSize);
    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        child: builder(brightness),
        overrides: overrides,
        brightness: brightness,
      ),
    );
    if (settle) {
      await tester.pumpAndSettle();
    } else {
      await pumpCaptureFrames(tester);
    }

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/${baseName}_$suffix.png'),
    );
    await tester.binding.setSurfaceSize(null);
  }

  if (variant == GoldenThemeVariant.lightOnly || variant == GoldenThemeVariant.both) {
    await snap(Brightness.light, 'light');
  }
  if (variant == GoldenThemeVariant.darkOnly || variant == GoldenThemeVariant.both) {
    await snap(Brightness.dark, 'dark');
  }
}

/// Pumps a bounded number of frames — avoids [pumpAndSettle] timeouts from
/// infinite animations (confetti, float, progress loops).
Future<void> pumpCaptureFrames(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
  await tester.pump(const Duration(milliseconds: 500));
}

Future<void> runRouterGolden(
  WidgetTester tester, {
  required String baseName,
  required PageRouteInfo<void> route,
  required SharedPreferences prefs,
  List<Override> overrides = const [],
  GoldenThemeVariant variant = GoldenThemeVariant.both,
  bool settle = true,
}) async {
  const logicalWidth = 390.0;
  const baselineHeight = 844.0;
  const baselineSize = Size(logicalWidth, baselineHeight);

  Future<void> snap(Brightness brightness, String suffix) async {
    final router = AppRouter();
    await tester.binding.setSurfaceSize(baselineSize);
    await tester.pumpWidget(
      buildTestRouterApp(
        prefs: prefs,
        appRouter: router,
        overrides: overrides,
        brightness: brightness,
      ),
    );
    await tester.pump();
    await router.replaceAll([route]);
    if (settle) {
      await tester.pumpAndSettle();
    } else {
      await pumpCaptureFrames(tester);
    }

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/${baseName}_$suffix.png'),
    );
    await tester.binding.setSurfaceSize(null);
  }

  if (variant == GoldenThemeVariant.lightOnly || variant == GoldenThemeVariant.both) {
    await snap(Brightness.light, 'light');
  }
  if (variant == GoldenThemeVariant.darkOnly || variant == GoldenThemeVariant.both) {
    await snap(Brightness.dark, 'dark');
  }
}
