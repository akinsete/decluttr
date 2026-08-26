import 'package:decluttr/core/formatting/display_number_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatAppCount', () {
    test('formats thousands with comma in en', () {
      expect(formatAppCount(1000, 'en'), '1,000');
      expect(formatAppCount(12864, 'en'), '12,864');
    });

    test('formats zero', () {
      expect(formatAppCount(0, 'en'), '0');
    });
  });
}
