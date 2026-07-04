import 'package:decluttr/core/di/providers.dart';
import 'package:decluttr/core/testing/widget_keys.dart';
import 'package:decluttr/features/home/home/home_page.dart';
import 'package:decluttr/features/home/home/home_vm_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('home shows module cards for first visit', (tester) async {
    final prefs = await initTestPrefs();
    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        overrides: [
          appStateProvider.overrideWith(_FirstVisitAppState.new),
          homeScreenVmProvider.overrideWith(_FirstVisitHomeVm.new),
        ],
        child: const HomePage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(WidgetKeys.homePage), findsOneWidget);
    expect(find.byKey(WidgetKeys.homeContactsCard), findsOneWidget);
    expect(find.byKey(WidgetKeys.homePhotosCard), findsOneWidget);
    expect(find.text('Tap to get started'), findsNWidgets(2));
  });
}

class _FirstVisitAppState extends AppStateNotifier {
  @override
  AppState build() => const AppState(isLoading: false, hasActivity: false);
}

class _FirstVisitHomeVm extends HomeScreenVmNotifier {
  @override
  Future<HomeScreenVm> build() async {
    return const HomeScreenVm(
      isFirstVisit: true,
      streakDays: 0,
      contactsCount: 11,
      photosCount: 95,
      progress: 0,
      kept: 0,
      deleted: 0,
      isLoading: false,
    );
  }
}
