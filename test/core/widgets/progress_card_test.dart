import 'package:decluttr/core/testing/widget_keys.dart';
import 'package:decluttr/core/widgets/progress_card.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('entire progress card invokes onViewAll', (tester) async {
    final prefs = await initTestPrefs();
    var taps = 0;

    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        child: ProgressCard(
          title: 'Your progress',
          kept: 10,
          deleted: 5,
          itemsRemaining: 20,
          progress: 0.4,
          viewAllLabel: 'View all stats ›',
          keptLabel: 'Kept',
          deletedLabel: 'Deleted',
          itemsRemainingLabel: 'items remaining',
          onViewAll: () => taps++,
        ),
      ),
    );
    await pumpCaptureFrames(tester);

    await tester.tap(find.byKey(WidgetKeys.homeProgressRing));
    await tester.pump();
    expect(taps, 1);

    await tester.tap(find.byKey(WidgetKeys.homeProgressViewAll));
    await tester.pump();
    expect(taps, 2);
  });
}
