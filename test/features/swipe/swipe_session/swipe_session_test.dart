import 'package:decluttr/core/testing/widget_keys.dart';
import 'package:decluttr/features/shared/domain/entities/swipe_item.dart';
import 'package:decluttr/features/swipe/swipe_session/swipe_session_notifier.dart';
import 'package:decluttr/features/swipe/swipe_session/swipe_session_page.dart';
import 'package:decluttr/features/swipe/swipe_session/swipe_session_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_app.dart';

const _swipeArgs = SwipeSessionArgs(
  batchId: '2026-05',
  batchTitle: 'May 2026',
  isPhotos: true,
);

void main() {
  testWidgets('swipe session shows tutorial overlay on first visit', (tester) async {
    final prefs = await initTestPrefs();
    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        overrides: [
          swipeSessionProvider(_swipeArgs).overrideWith(_TutorialSwipeSession.new),
        ],
        child: const SwipeSessionPage(
          batchId: '2026-05',
          batchTitle: 'May 2026',
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(WidgetKeys.swipeTutorialOverlay), findsOneWidget);
    expect(find.text("Here's how it works"), findsOneWidget);
    expect(find.text('Got it'), findsOneWidget);
  });
}

class _TutorialSwipeSession extends SwipeSessionNotifier {
  _TutorialSwipeSession() : super(_swipeArgs);

  @override
  SwipeSessionState build() {
    return const SwipeSessionState(
      batchId: '2026-05',
      batchTitle: 'May 2026',
      isPhotos: true,
      isLoading: false,
      showTutorial: true,
      items: [
        SwipeItem(
          id: '1',
          title: 'Beach trip',
          subtitle: 'June 2026 · 2.4 MB',
          gradientIndex: 0,
        ),
      ],
    );
  }
}
