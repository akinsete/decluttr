import 'dart:async';

import 'package:decluttr/core/testing/widget_keys.dart';
import 'package:decluttr/features/streak/streak/streak_page.dart';
import 'package:decluttr/features/streak/streak/streak_vm.dart';
import 'package:decluttr/features/streak/streak/streak_vm_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_app.dart';

void main() {
  testWidgets('streak page shows hero, stats, and keep cleaning CTA', (tester) async {
    final prefs = await initTestPrefs();

    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        overrides: [streakVmProvider.overrideWith(_LoadedStreakVm.new)],
        child: const StreakPage(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byKey(WidgetKeys.streakPage), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(find.text('Day Streak'), findsOneWidget);
    expect(find.text('Keep it going!'), findsOneWidget);
    expect(find.text('Last 5 weeks'), findsOneWidget);
    expect(find.text('Longest streak'), findsOneWidget);
    expect(find.text('Items cleaned'), findsOneWidget);
    expect(find.text('1,248'), findsOneWidget);
    expect(find.byKey(WidgetKeys.streakKeepCleaningButton), findsOneWidget);
  });

  testWidgets('streak page shows loading indicator while vm loads', (tester) async {
    final prefs = await initTestPrefs();

    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        overrides: [streakVmProvider.overrideWith(_LoadingStreakVm.new)],
        child: const StreakPage(),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}

class _LoadedStreakVm extends StreakVmNotifier {
  @override
  Future<StreakVm> build() async {
    return const StreakVm(
      currentStreak: 4,
      longestStreak: 12,
      itemsCleaned: 1248,
      weekActivity: [true, true, true, true, false, false, false],
      heatmap: [
        2, 4, 1, 5, 3, 0, 2,
        4, 3, 1, 5, 2, 4, 3,
        2, 1, 4, 5, 3, 2, 1,
        0, 3, 4, 2, 5, 3, 1,
        4, 2, 3, 5, 1, 2, 4,
      ],
      todayWeekdayIndex: 3,
      heatmapTodayIndex: 31,
    );
  }
}

class _LoadingStreakVm extends StreakVmNotifier {
  static final _never = Completer<StreakVm>();

  @override
  Future<StreakVm> build() async => _never.future;
}
