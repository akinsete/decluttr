import 'package:decluttr/core/widgets/swipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('SwipeCardController runs fly-away before keep callback', (tester) async {
    final prefs = await initTestPrefs();
    final controller = SwipeCardController();
    var kept = false;

    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        child: SizedBox(
          width: 320,
          height: 480,
          child: SwipeCard(
            controller: controller,
            title: 'Beach trip',
            subtitle: 'June 2026',
            onSwipeKeep: () async => kept = true,
          ),
        ),
      ),
    );

    expect(kept, isFalse);

    controller.swipeKeep();
    await tester.pump();
    expect(kept, isFalse);

    await tester.pump(const Duration(milliseconds: 300));
    expect(kept, isTrue);
  });

  testWidgets('SwipeCardController runs fly-away before delete callback', (tester) async {
    final prefs = await initTestPrefs();
    final controller = SwipeCardController();
    var deleted = false;

    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        child: SizedBox(
          width: 320,
          height: 480,
          child: SwipeCard(
            controller: controller,
            title: 'Beach trip',
            subtitle: 'June 2026',
            onSwipeDelete: () async => deleted = true,
          ),
        ),
      ),
    );

    controller.swipeDelete();
    await tester.pump();
    expect(deleted, isFalse);

    await tester.pump(const Duration(milliseconds: 300));
    expect(deleted, isTrue);
  });

  testWidgets(
    'SwipeCardController stays bound after keyed card replacement',
    (tester) async {
      final prefs = await initTestPrefs();
      final controller = SwipeCardController();
      var secondDelete = false;

      await tester.pumpWidget(
        buildTestApp(
          prefs: prefs,
          child: SizedBox(
            width: 320,
            height: 480,
            child: SwipeCard(
              key: const ValueKey('first'),
              controller: controller,
              title: 'First',
              subtitle: 'June 2026',
              onSwipeDelete: () async {},
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        buildTestApp(
          prefs: prefs,
          child: SizedBox(
            width: 320,
            height: 480,
            child: SwipeCard(
              key: const ValueKey('second'),
              controller: controller,
              title: 'Second',
              subtitle: 'June 2026',
              onSwipeDelete: () async => secondDelete = true,
            ),
          ),
        ),
      );
      await tester.pump();

      // Do not await here — fly-away uses delayed frames that need pump.
      controller.swipeDelete();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(secondDelete, isTrue);
    },
  );
}
