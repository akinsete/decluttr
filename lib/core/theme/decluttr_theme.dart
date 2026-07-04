import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'decluttr_theme_colors.dart';

part 'decluttr_theme.tailor.dart';

/// Decluttr brand tokens — colors, spacing, radii via **Theme Tailor**.
///
/// Gradients and shadow presets are computed getters on this extension.
/// Access in widgets via [context.decluttrTheme], not [DecluttrTheme.light].
@TailorMixin(themeGetter: ThemeGetter.none)
class DecluttrTheme extends ThemeExtension<DecluttrTheme> with _$DecluttrThemeTailorMixin {
  const DecluttrTheme({
    required this.canvas,
    required this.canvasAlt,
    required this.surfaceCard,
    required this.white,
    required this.divider,
    required this.ink,
    required this.blue,
    required this.pink,
    required this.pinkHot,
    required this.lavender,
    required this.yellow,
    required this.mint,
    required this.success,
    required this.successText,
    required this.destructive,
    required this.destructiveStrong,
    required this.destructiveText,
    required this.iosSystemBlue,
    required this.textSecondary,
    required this.walkthroughMuted,
    required this.walkthroughKeep,
    required this.walkthroughDelete,
    required this.walkthroughTap,
    required this.streakFill,
    required this.streakBorder,
    required this.errorCircle,
    required this.errorIcon,
    required this.dockInactive,
    required this.x1,
    required this.x2,
    required this.x3,
    required this.x4,
    required this.x5,
    required this.x6,
    required this.x7,
    required this.x8,
    required this.x9,
    required this.x10,
    required this.x11,
    required this.screenH,
    required this.screenHLoose,
    required this.dockClearance,
    required this.radiusXs,
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
    required this.radiusXl,
    required this.radiusXxl,
    required this.radiusCard,
    required this.radiusPill,
    required this.radiusHero,
    required this.radiusFull,
  });

  static const DecluttrTheme light = DecluttrTheme(
    canvas: DecluttrThemeColors.canvas,
    canvasAlt: DecluttrThemeColors.canvasAlt,
    surfaceCard: DecluttrThemeColors.surfaceCard,
    white: DecluttrThemeColors.white,
    divider: DecluttrThemeColors.divider,
    ink: DecluttrThemeColors.ink,
    blue: DecluttrThemeColors.blue,
    pink: DecluttrThemeColors.pink,
    pinkHot: DecluttrThemeColors.pinkHot,
    lavender: DecluttrThemeColors.lavender,
    yellow: DecluttrThemeColors.yellow,
    mint: DecluttrThemeColors.mint,
    success: DecluttrThemeColors.success,
    successText: DecluttrThemeColors.successText,
    destructive: DecluttrThemeColors.destructive,
    destructiveStrong: DecluttrThemeColors.destructiveStrong,
    destructiveText: DecluttrThemeColors.destructiveText,
    iosSystemBlue: DecluttrThemeColors.iosSystemBlue,
    textSecondary: DecluttrThemeColors.textSecondary,
    walkthroughMuted: DecluttrThemeColors.walkthroughMuted,
    walkthroughKeep: DecluttrThemeColors.walkthroughKeep,
    walkthroughDelete: DecluttrThemeColors.walkthroughDelete,
    walkthroughTap: DecluttrThemeColors.walkthroughTap,
    streakFill: DecluttrThemeColors.streakFill,
    streakBorder: DecluttrThemeColors.streakBorder,
    errorCircle: DecluttrThemeColors.errorCircle,
    errorIcon: DecluttrThemeColors.errorIcon,
    dockInactive: DecluttrThemeColors.dockInactive,
    x1: 4,
    x2: 8,
    x3: 12,
    x4: 16,
    x5: 20,
    x6: 24,
    x7: 26,
    x8: 32,
    x9: 40,
    x10: 48,
    x11: 64,
    screenH: 22,
    screenHLoose: 30,
    dockClearance: 128,
    radiusXs: 12,
    radiusSm: 14,
    radiusMd: 16,
    radiusLg: 18,
    radiusXl: 22,
    radiusXxl: 24,
    radiusCard: 26,
    radiusPill: 28,
    radiusHero: 32,
    radiusFull: 999,
  );

  static const DecluttrTheme dark = DecluttrTheme(
    canvas: DecluttrThemeColors.darkCanvas,
    canvasAlt: DecluttrThemeColors.darkCanvas,
    surfaceCard: DecluttrThemeColors.darkSurface,
    white: DecluttrThemeColors.white,
    divider: Color(0x24FFFFFF),
    ink: DecluttrThemeColors.white,
    blue: DecluttrThemeColors.blue,
    pink: DecluttrThemeColors.pink,
    pinkHot: DecluttrThemeColors.pinkHot,
    lavender: DecluttrThemeColors.lavender,
    yellow: DecluttrThemeColors.yellow,
    mint: DecluttrThemeColors.mint,
    success: DecluttrThemeColors.success,
    successText: DecluttrThemeColors.successText,
    destructive: DecluttrThemeColors.destructive,
    destructiveStrong: DecluttrThemeColors.destructiveStrong,
    destructiveText: DecluttrThemeColors.destructiveText,
    iosSystemBlue: DecluttrThemeColors.iosSystemBlue,
    textSecondary: Color(0xFFAEAEB2),
    walkthroughMuted: Color(0xFF9A9088),
    walkthroughKeep: DecluttrThemeColors.walkthroughKeep,
    walkthroughDelete: DecluttrThemeColors.walkthroughDelete,
    walkthroughTap: DecluttrThemeColors.walkthroughTap,
    streakFill: Color(0xFF2A2228),
    streakBorder: Color(0xFF3D3238),
    errorCircle: Color(0xFF3D2820),
    errorIcon: DecluttrThemeColors.errorIcon,
    dockInactive: Color(0xFF8A8078),
    x1: 4,
    x2: 8,
    x3: 12,
    x4: 16,
    x5: 20,
    x6: 24,
    x7: 26,
    x8: 32,
    x9: 40,
    x10: 48,
    x11: 64,
    screenH: 22,
    screenHLoose: 30,
    dockClearance: 128,
    radiusXs: 12,
    radiusSm: 14,
    radiusMd: 16,
    radiusLg: 18,
    radiusXl: 22,
    radiusXxl: 24,
    radiusCard: 26,
    radiusPill: 28,
    radiusHero: 32,
    radiusFull: 999,
  );

  Color inkA(double alpha) => ink.withValues(alpha: alpha);

  LinearGradient get heroGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFFD666),
          Color(0xFFFF9EC0),
          Color(0xFFCBB8FF),
        ],
        stops: [0, 0.48, 1],
      );

  LinearGradient get contactsCardGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFE9F3FF), Color(0xFFCFE6FF)],
      );

  LinearGradient get photosCardGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFF0F6), Color(0xFFFBD3E4)],
      );

  LinearGradient get progressRingGradient => const LinearGradient(
        colors: [Color(0xFF5C9BFF), Color(0xFFFF6FA8)],
      );

  LinearGradient get primaryCtaGradient => const LinearGradient(
        begin: Alignment(-0.05, -1),
        end: Alignment(0.05, 1),
        colors: [Color(0xFFFF4F93), Color(0xFFFF7BB8)],
      );

  LinearGradient get headlinePinkGradient => const LinearGradient(
        begin: Alignment(-0.05, -1),
        end: Alignment(0.05, 1),
        colors: [Color(0xFFFF4F93), Color(0xFFFF6FA8)],
      );

  LinearGradient get walkthroughFrontGradient => const LinearGradient(
        begin: Alignment(-0.87, -1),
        end: Alignment(0.87, 1),
        colors: [Color(0xFFFFD9E8), Color(0xFFF7A2C8)],
      );

  LinearGradient get walkthroughBackGradient => const LinearGradient(
        begin: Alignment(-0.87, -1),
        end: Alignment(0.87, 1),
        colors: [Color(0xFFEDE3FF), Color(0xFFCBB8FF)],
      );

  LinearGradient get premiumGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFD666), Color(0xFFFF9EC0), Color(0xFFCBB8FF)],
      );

  List<BoxShadow> get shadowXs => const [
        BoxShadow(
          color: Color(0x0F000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ];

  List<BoxShadow> get shadowSm => const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ];

  List<BoxShadow> get shadowMd => const [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 16,
          offset: Offset(0, 6),
        ),
      ];

  List<BoxShadow> get shadowStack => const [
        BoxShadow(
          color: Color(0x0D000000),
          blurRadius: 20,
          offset: Offset(0, 10),
        ),
      ];

  List<BoxShadow> get shadowHero => const [
        BoxShadow(
          color: Color(0x24000000),
          blurRadius: 40,
          offset: Offset(0, 18),
        ),
      ];

  List<BoxShadow> get shadowCardActive => const [
        BoxShadow(
          color: Color(0x2E000000),
          blurRadius: 44,
          offset: Offset(0, 20),
        ),
      ];

  List<BoxShadow> get shadowDock => const [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 28,
          offset: Offset(0, 10),
        ),
      ];

  /// Hairline edge for frosted dock (`divider-hairline` in handoff tokens).
  Color get dockHairlineBorder => const Color(0x0F000000);

  /// Pink-tinted shadow for the floating bottom dock (prototype handoff).
  List<BoxShadow> get shadowDockFloating => const [
        BoxShadow(
          color: Color(0x33B48296),
          blurRadius: 32,
          offset: Offset(0, 12),
        ),
      ];

  LinearGradient get dockIndicatorGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFF4F93), Color(0xFFFF7BB8)],
      );

  List<BoxShadow> get shadowSheet => const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 40,
          offset: Offset(0, -10),
        ),
      ];

  @override
  final Color canvas;
  @override
  final Color canvasAlt;
  @override
  final Color surfaceCard;
  @override
  final Color white;
  @override
  final Color divider;
  @override
  final Color ink;
  @override
  final Color blue;
  @override
  final Color pink;
  @override
  final Color pinkHot;
  @override
  final Color lavender;
  @override
  final Color yellow;
  @override
  final Color mint;
  @override
  final Color success;
  @override
  final Color successText;
  @override
  final Color destructive;
  @override
  final Color destructiveStrong;
  @override
  final Color destructiveText;
  @override
  final Color iosSystemBlue;
  @override
  final Color textSecondary;
  @override
  final Color walkthroughMuted;
  @override
  final Color walkthroughKeep;
  @override
  final Color walkthroughDelete;
  @override
  final Color walkthroughTap;
  @override
  final Color streakFill;
  @override
  final Color streakBorder;
  @override
  final Color errorCircle;
  @override
  final Color errorIcon;
  @override
  final Color dockInactive;
  @override
  final double x1;
  @override
  final double x2;
  @override
  final double x3;
  @override
  final double x4;
  @override
  final double x5;
  @override
  final double x6;
  @override
  final double x7;
  @override
  final double x8;
  @override
  final double x9;
  @override
  final double x10;
  @override
  final double x11;
  @override
  final double screenH;
  @override
  final double screenHLoose;
  @override
  final double dockClearance;
  @override
  final double radiusXs;
  @override
  final double radiusSm;
  @override
  final double radiusMd;
  @override
  final double radiusLg;
  @override
  final double radiusXl;
  @override
  final double radiusXxl;
  @override
  final double radiusCard;
  @override
  final double radiusPill;
  @override
  final double radiusHero;
  @override
  final double radiusFull;
}

extension DecluttrThemeBuildContext on BuildContext {
  DecluttrTheme get decluttrTheme =>
      Theme.of(this).extension<DecluttrTheme>() ??
      (Theme.of(this).brightness == Brightness.dark
          ? DecluttrTheme.dark
          : DecluttrTheme.light);
}
