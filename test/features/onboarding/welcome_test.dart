import 'package:decluttr/core/testing/widget_keys.dart';
import 'package:decluttr/features/onboarding/welcome/welcome_page.dart';
import 'package:decluttr/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('welcome shows logo and get started', (tester) async {
    final prefs = await initTestPrefs();
    final l10n = lookupAppLocalizations(const Locale('en'));

    await tester.pumpWidget(
      buildTestApp(prefs: prefs, child: const WelcomePage()),
    );
    await pumpCaptureFrames(tester);

    expect(find.byKey(WidgetKeys.welcomePage), findsOneWidget);
    expect(find.byKey(WidgetKeys.welcomeGetStarted), findsOneWidget);
    expect(find.text(l10n.welcomeGetStarted), findsOneWidget);
    expect(find.text(l10n.welcomeHeadlineSuffix), findsOneWidget);
  });
}
