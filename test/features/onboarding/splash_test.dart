import 'package:decluttr/app/router/app_router.dart';
import 'package:decluttr/core/di/app_state.dart';
import 'package:decluttr/core/di/providers.dart';
import 'package:decluttr/core/testing/widget_keys.dart';
import 'package:decluttr/features/home/home/home_vm_notifier.dart';
import 'package:decluttr/features/onboarding/splash/splash_page.dart';
import 'package:decluttr/features/trash/trash/trash_notifier.dart';
import 'package:decluttr/features/trash/trash/trash_state.dart';
import 'package:decluttr/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('splash shows cluster and progress', (tester) async {
    final prefs = await initTestPrefs();
    final l10n = lookupAppLocalizations(const Locale('en'));

    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        overrides: [
          appStateProvider.overrideWith(_PendingOnboardingAppState.new),
        ],
        child: const SplashPage(),
      ),
    );
    await tester.pump();

    expect(find.byKey(WidgetKeys.splashPage), findsOneWidget);
    expect(find.byKey(WidgetKeys.splashProgress), findsOneWidget);
    expect(find.text(l10n.splashTagline), findsOneWidget);
  });

  testWidgets('splash navigates to welcome when onboarding is incomplete', (tester) async {
    final prefs = await initTestPrefs();
    final router = AppRouter();

    await tester.binding.setSurfaceSize(const Size(390, 844));
    await tester.pumpWidget(
      buildTestRouterApp(
        prefs: prefs,
        appRouter: router,
        overrides: [
          appStateProvider.overrideWith(_PendingOnboardingAppState.new),
        ],
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 2300));
    await pumpCaptureFrames(tester);

    expect(find.byKey(WidgetKeys.welcomePage), findsOneWidget);
    expect(find.byKey(WidgetKeys.homePage), findsNothing);
  });

  testWidgets('splash navigates to home when onboarding is complete', (tester) async {
    final prefs = await initTestPrefs({'onboarding_complete': true});
    final router = AppRouter();

    await tester.binding.setSurfaceSize(const Size(390, 844));
    await tester.pumpWidget(
      buildTestRouterApp(
        prefs: prefs,
        appRouter: router,
        overrides: [
          appStateProvider.overrideWith(_CompletedOnboardingAppState.new),
          homeScreenVmProvider.overrideWith(_ReturningHomeVm.new),
          trashUiProvider.overrideWith(_EmptyTrashUi.new),
        ],
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 2300));
    await pumpCaptureFrames(tester);

    expect(find.byKey(WidgetKeys.homePage), findsOneWidget);
    expect(find.byKey(WidgetKeys.welcomePage), findsNothing);
  });
}

class _EmptyTrashUi extends TrashUiNotifier {
  @override
  TrashUiState build() => const TrashUiState(isLoading: false);
}

class _PendingOnboardingAppState extends AppStateNotifier {
  @override
  AppState build() => const AppState(isLoading: false);
}

class _CompletedOnboardingAppState extends AppStateNotifier {
  @override
  AppState build() => const AppState(isLoading: false, onboardingComplete: true);
}

class _ReturningHomeVm extends HomeScreenVmNotifier {
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
