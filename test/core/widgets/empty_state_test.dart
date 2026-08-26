import 'package:decluttr/core/testing/widget_keys.dart';
import 'package:decluttr/core/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('EmptyState fills available height and centers content', (tester) async {
    final prefs = await initTestPrefs();
    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        child: const Scaffold(
          body: EmptyState(
            title: 'Trash is empty',
            subtitle: 'Items you swipe away land here.',
          ),
        ),
      ),
    );

    final box = tester.renderObject<RenderBox>(find.byKey(WidgetKeys.emptyState));
    final scaffoldBox = tester.renderObject<RenderBox>(find.byType(Scaffold));

    expect(box.size.height, scaffoldBox.size.height);
    expect(find.text('Trash is empty'), findsOneWidget);
  });
}
