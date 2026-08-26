import 'dart:async';

import 'package:decluttr/core/testing/widget_keys.dart';
import 'package:decluttr/features/insights/insights/insights_page.dart';
import 'package:decluttr/features/insights/insights/insights_vm.dart';
import 'package:decluttr/features/insights/insights/insights_vm_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_app.dart';

void main() {
  testWidgets('insights page shows hero, stats, chart, and streak row', (tester) async {
    final prefs = await initTestPrefs();

    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        overrides: [insightsVmProvider.overrideWith(_LoadedInsightsVm.new)],
        child: const InsightsPage(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byKey(WidgetKeys.insightsPage), findsOneWidget);
    expect(find.text('Insights'), findsOneWidget);
    expect(find.text('Storage freed'), findsOneWidget);
    expect(find.text('This week'), findsOneWidget);
    expect(find.text('Cleaned by type'), findsOneWidget);
    expect(find.byKey(WidgetKeys.insightsWeekChart), findsOneWidget);
    expect(find.byKey(WidgetKeys.insightsStreakRow), findsOneWidget);
    expect(find.text('2,914'), findsOneWidget);
    expect(find.text('1,248'), findsOneWidget);
  });

  testWidgets('insights page shows loading indicator while vm loads', (tester) async {
    final prefs = await initTestPrefs();

    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        overrides: [insightsVmProvider.overrideWith(_LoadingInsightsVm.new)],
        child: const InsightsPage(),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}

class _LoadedInsightsVm extends InsightsVmNotifier {
  @override
  Future<InsightsVm> build() async {
    return const InsightsVm(
      totalKept: 2914,
      totalDeleted: 1248,
      committedDeletedBytes: 240000000,
      photosDeleted: 1032,
      contactsDeleted: 216,
      weekCleanedCounts: [40, 52, 36, 80, 104, 0, 0],
      todayWeekdayIndex: 4,
      currentStreak: 4,
      longestStreak: 12,
    );
  }
}

class _LoadingInsightsVm extends InsightsVmNotifier {
  static final _never = Completer<InsightsVm>();

  @override
  Future<InsightsVm> build() async => _never.future;
}
