import 'package:decluttr/core/testing/widget_keys.dart';
import 'package:decluttr/features/shared/domain/entities/swipe_item.dart';
import 'package:decluttr/features/swipe/swipe_session/swipe_session_notifier.dart';
import 'package:decluttr/features/swipe/swipe_session/swipe_session_page.dart';
import 'package:decluttr/features/swipe/swipe_session/swipe_session_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_app.dart';

const _swipeArgs = SwipeSessionArgs(
  batchId: 'a-m',
  batchTitle: 'A–M',
  isPhotos: false,
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
          batchId: 'a-m',
          batchTitle: 'A–M',
          isPhotos: false,
        ),
      ),
    );
    await pumpCaptureFrames(tester);

    expect(find.byKey(WidgetKeys.swipeTutorialOverlay), findsOneWidget);
    expect(find.text("Here's how it works"), findsOneWidget);
    expect(find.text('Got it'), findsOneWidget);
  });

  testWidgets('swipe session exposes close button', (tester) async {
    final prefs = await initTestPrefs({'tutorial_seen': true});
    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        overrides: [
          swipeSessionProvider(_swipeArgs).overrideWith(_LoadedSwipeSession.new),
        ],
        child: const SwipeSessionPage(
          batchId: 'a-m',
          batchTitle: 'A–M',
          isPhotos: false,
        ),
      ),
    );
    await pumpCaptureFrames(tester);

    expect(find.byKey(WidgetKeys.swipeSessionPage), findsOneWidget);
    expect(find.byKey(WidgetKeys.swipeCloseButton), findsOneWidget);
  });
}

class _TutorialSwipeSession extends SwipeSessionNotifier {
  _TutorialSwipeSession() : super(_swipeArgs);

  @override
  SwipeSessionState build() {
    return const SwipeSessionState(
      batchId: 'a-m',
      batchTitle: 'A–M',
      isPhotos: false,
      isLoading: false,
      showTutorial: true,
      items: [
        SwipeItem(
          id: '1',
          title: 'Alex Morgan',
          subtitle: '555-0100',
          gradientIndex: 0,
        ),
      ],
    );
  }
}

class _LoadedSwipeSession extends SwipeSessionNotifier {
  _LoadedSwipeSession() : super(_swipeArgs);

  @override
  SwipeSessionState build() {
    return const SwipeSessionState(
      batchId: 'a-m',
      batchTitle: 'A–M',
      isPhotos: false,
      isLoading: false,
      showTutorial: false,
      items: [
        SwipeItem(
          id: '1',
          title: 'Alex Morgan',
          subtitle: '555-0100',
          gradientIndex: 0,
        ),
      ],
    );
  }
}
