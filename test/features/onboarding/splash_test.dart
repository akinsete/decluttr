import 'package:decluttr/core/testing/widget_keys.dart';
import 'package:decluttr/features/onboarding/splash/splash_page.dart';
import 'package:decluttr/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('splash shows cluster and progress', (tester) async {
    final prefs = await initTestPrefs();
    final l10n = lookupAppLocalizations(const Locale('en'));

    await tester.pumpWidget(
      buildTestApp(prefs: prefs, child: const SplashPage()),
    );
    await tester.pump();

    expect(find.byKey(WidgetKeys.splashPage), findsOneWidget);
    expect(find.byKey(WidgetKeys.splashProgress), findsOneWidget);
    expect(find.text(l10n.splashTagline), findsOneWidget);
  });
}
