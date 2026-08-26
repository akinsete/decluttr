import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Locale-aware integer display (e.g. `1000` → `1,000` in en_US).
String formatAppCount(num value, [String? localeName]) {
  return NumberFormat.decimalPattern(localeName).format(value);
}

extension DisplayNumberFormatting on BuildContext {
  String formatDisplayCount(num value) {
    return formatAppCount(value, Localizations.localeOf(this).toString());
  }
}
