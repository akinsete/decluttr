import 'package:decluttr/core/testing/widget_keys.dart';
import 'package:decluttr/features/swipe/session_summary/session_summary_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_app.dart';

void main() {
  testWidgets('session summary shows stat cards and deleted size', (tester) async {
    final prefs = await initTestPrefs();

    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        child: const SessionSummaryPage(
          kept: 3,
          deleted: 2,
          deletedBytes: 4800000,
          isPhotos: true,
        ),
      ),
    );
    await pumpCaptureFrames(tester);

    expect(find.byKey(WidgetKeys.sessionSummaryPage), findsOneWidget);
    expect(find.text('All done!'), findsOneWidget);
    expect(find.byKey(WidgetKeys.sessionSummaryKeptStat), findsOneWidget);
    expect(find.byKey(WidgetKeys.sessionSummaryDeletedStat), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.textContaining('4.8 MB'), findsOneWidget);
    expect(find.text('Back to batches'), findsOneWidget);
  });
}
