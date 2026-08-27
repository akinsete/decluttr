import 'package:decluttr/core/di/providers.dart';
import 'package:decluttr/core/di/trash_dock_badge_providers.dart';
import 'package:decluttr/core/testing/widget_keys.dart';
import 'package:decluttr/core/widgets/dock_count_badge.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('DockCountBadge hidden when count is zero', (tester) async {
    final prefs = await initTestPrefs();
    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        child: const DockCountBadge(
          count: 0,
          semanticsLabel: 'No items in trash',
        ),
      ),
    );

    expect(find.byKey(WidgetKeys.trashDockBadge), findsNothing);
  });

  testWidgets('DockCountBadge shows count and bounces when visible', (tester) async {
    final prefs = await initTestPrefs();
    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        child: const DockCountBadge(
          count: 3,
          semanticsLabel: '3 items in trash',
        ),
      ),
    );

    expect(find.byKey(WidgetKeys.trashDockBadge), findsOneWidget);
    expect(find.text('3'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 700));
    await tester.pump();

    expect(find.byKey(WidgetKeys.trashDockBadge), findsOneWidget);
  });

  test('bumpTrashDockBadge refreshes trash item count provider', () async {
    final prefs = await initTestPrefs();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(container.dispose);

    expect(container.read(trashRevisionProvider), 0);

    container.read(trashRevisionProvider.notifier).bump();
    expect(container.read(trashRevisionProvider), 1);
  });
}
