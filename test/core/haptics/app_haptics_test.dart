import 'package:decluttr/core/haptics/app_haptics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('decision and undo no-op when disabled', () async {
    var pulses = 0;
    final haptics = AppHaptics(
      isEnabled: () => false,
      medium: () async {
        pulses++;
      },
      light: () async {
        pulses++;
      },
    );

    await haptics.decision();
    await haptics.undo();
    expect(pulses, 0);
  });

  test('decision and undo fire when enabled', () async {
    var medium = 0;
    var light = 0;
    final haptics = AppHaptics(
      isEnabled: () => true,
      medium: () async {
        medium++;
      },
      light: () async {
        light++;
      },
    );

    await haptics.decision();
    await haptics.undo();
    expect(medium, 1);
    expect(light, 1);
  });
}
