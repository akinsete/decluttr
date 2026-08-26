import 'package:decluttr/features/shared/domain/entities/photo_size_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatPhotoSizeBytes', () {
    test('formats megabytes', () {
      expect(formatPhotoSizeBytes(2400000), '2.4 MB');
    });

    test('formats kilobytes', () {
      expect(formatPhotoSizeBytes(1500), '1.5 KB');
    });
  });

  group('photoCardSubtitle', () {
    test('combines month label and size', () {
      final subtitle = photoCardSubtitle(DateTime(2026, 7), 2400000);
      expect(subtitle, contains('2026'));
      expect(subtitle, contains('2.4 MB'));
    });
  });
}
