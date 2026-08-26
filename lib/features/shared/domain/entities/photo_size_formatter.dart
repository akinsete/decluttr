import 'package:intl/intl.dart';

import 'package:decluttr/core/formatting/display_number_formatter.dart';

/// Formats byte counts for photo cards and stats (e.g. `2.4 MB`).
String formatPhotoSizeBytes(int bytes, [String? localeName]) {
  if (bytes < 1000) return '${formatAppCount(bytes, localeName)} B';
  if (bytes < 1000000) {
    return '${NumberFormat('#,##0.0', localeName).format(bytes / 1000)} KB';
  }
  return '${NumberFormat('#,##0.0', localeName).format(bytes / 1000000)} MB';
}

/// Card subtitle: `July 2026 · 2.4 MB` (date only when size is unknown).
String photoCardSubtitle(DateTime date, int sizeBytes, [String? localeName]) {
  final monthLabel = DateFormat.yMMMM(localeName).format(date);
  if (sizeBytes <= 0) return monthLabel;
  return '$monthLabel · ${formatPhotoSizeBytes(sizeBytes, localeName)}';
}

/// Formats a video length in whole seconds as `m:ss` (e.g. `0:18`, `12:05`).
String formatVideoDurationSeconds(int seconds) {
  final safe = seconds < 0 ? 0 : seconds;
  final minutes = safe ~/ 60;
  final remainder = safe % 60;
  final padded = remainder < 10 ? '0$remainder' : '$remainder';
  return '$minutes:$padded';
}
