import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'decluttr_theme.dart';

/// Typography tokens — Plus Jakarta Sans via google_fonts.
abstract final class AppText {
  static TextTheme buildTextTheme(DecluttrTheme tokens) {
    final base = GoogleFonts.plusJakartaSansTextTheme();
    return base.copyWith(
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        height: 1.18,
        letterSpacing: -0.4,
        color: tokens.ink,
      ),
      headlineLarge: GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.12,
        letterSpacing: -0.6,
        color: tokens.ink,
      ),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        height: 1.15,
        letterSpacing: -0.5,
        color: tokens.ink,
      ),
      headlineSmall: GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        height: 1.2,
        color: tokens.ink,
      ),
      titleLarge: GoogleFonts.plusJakartaSans(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: tokens.ink,
      ),
      titleMedium: GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        height: 1.4,
        color: tokens.ink,
      ),
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 14.5,
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: tokens.ink,
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: tokens.inkA(0.65),
      ),
      bodySmall: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 1.4,
        letterSpacing: 0.4,
        color: tokens.inkA(0.55),
      ),
      labelLarge: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: tokens.ink,
      ),
      labelSmall: GoogleFonts.plusJakartaSans(
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        color: tokens.inkA(0.55),
      ),
    );
  }
}

extension AppTextContext on BuildContext {
  TextTheme get appText => Theme.of(this).textTheme;
}
