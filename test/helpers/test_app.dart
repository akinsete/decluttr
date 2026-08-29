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
import 'package:decluttr/features/shared/domain/repositories/auth_repository.dart';
import 'package:decluttr/l10n/generated/app_localizations.dart';
import 'package:mockito/mockito.dart';

import 'mock_providers.mocks.dart';

export 'package:riverpod/src/framework.dart' show Override;

/// Auth stub so widget tests never touch [FirebaseAuth.instance].
MockAuthRepository createTestAuthRepository() {
  final mock = MockAuthRepository();
  when(mock.currentUserId).thenReturn(null);
  when(mock.isAnonymous).thenReturn(true);
  when(mock.ensureAnonymousUser()).thenAnswer((_) async => null);
  when(
    mock.linkWithEmail(
      email: anyNamed('email'),
      password: anyNamed('password'),
    ),
  ).thenAnswer((_) async {});
  return mock;
}

List<Override> coreTestOverrides({AuthRepository? authRepository}) => [
      authRepositoryProvider.overrideWithValue(
        authRepository ?? createTestAuthRepository(),
      ),
    ];

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

  // MaterialApp's default DefaultTextStyle is the yellow-underline "error"
  // style. Pages used as `home` without their own Scaffold/Material (e.g.
  // HomePage inside a shell) inherit that — goldens/store shots get yellow bars.
  final scaffoldBg = brightness == Brightness.dark
      ? darkTheme.scaffoldBackgroundColor
      : theme.scaffoldBackgroundColor;

  return ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      ...coreTestOverrides(),
      ...overrides,
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: Material(
        color: scaffoldBg,
        child: child,
      ),
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
      ...coreTestOverrides(),
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
///
/// Also advances enough for [AsyncNotifier] / [FutureProvider] to emit data
/// before a golden capture (which can hang while tickers keep scheduling).
Future<void> pumpCaptureFrames(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 16));
  await tester.pump(const Duration(milliseconds: 100));
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
