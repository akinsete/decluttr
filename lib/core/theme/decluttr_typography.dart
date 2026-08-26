import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'decluttr_theme.dart';

/// Semantic text styles layered on [ThemeData.textTheme] (Plus Jakarta Sans).
///
/// Widgets must use [DecluttrTypographyBuildContext.decluttrTypography] — never
/// `textTheme.*.copyWith(fontSize: …)` or other metric overrides in feature code.
@immutable
class DecluttrTypography extends ThemeExtension<DecluttrTypography> {
  const DecluttrTypography({
    required this.homeEyebrow,
    required this.homeHero,
    required this.homeHeroAccent,
    required this.homeHeroSub,
    required this.permissionTitle,
    required this.permissionSubtitle,
    required this.permissionBullet,
    required this.permissionDismiss,
    required this.welcomeHeadline,
    required this.welcomeHeadlineMasked,
    required this.welcomeSubtitle,
    required this.welcomeSecondaryAction,
    required this.welcomeReplayLabel,
    required this.splashTagline,
    required this.walkthroughTitle,
    required this.walkthroughSubtitle,
    required this.walkthroughDemoLabel,
    required this.walkthroughSwipeStamp,
    required this.walkthroughHint,
    required this.moduleCardTitle,
    required this.moduleCardSubtitle,
    required this.primaryCta,
    required this.primaryButton,
    required this.statusPill,
    required this.segmentedLabelSelected,
    required this.segmentedLabelUnselected,
    required this.swipeStamp,
    required this.homeProgressRingNumber,
    required this.homeProgressRingCaption,
    required this.homeProgressSideCount,
    required this.sessionSummaryStatCount,
    required this.streakHeroNumber,
    required this.streakDayStreakLabel,
    required this.streakKeepGoing,
    required this.streakWeekdayLetter,
    required this.streakHeatmapMeta,
    required this.streakStatCount,
    required this.streakStatLabel,
    required this.streakLegendLabel,
  });

  /// Home eyebrow — 12 / w700 / pinkHot.
  final TextStyle homeEyebrow;

  /// Home hero primary lines — 32 / w700 / ink.
  final TextStyle homeHero;

  /// Home hero accent span — 32 / w700 / pinkHot.
  final TextStyle homeHeroAccent;

  /// Home hero subtitle — 12 / w500 / textSecondary.
  final TextStyle homeHeroSub;

  /// Permission screen title — 28 / w800 / ink.
  final TextStyle permissionTitle;

  /// Permission screen subtitle — 15 / w500 / textSecondary.
  final TextStyle permissionSubtitle;

  /// Permission privacy bullet — 14 / w500 / textSecondary.
  final TextStyle permissionBullet;

  /// Permission dismiss CTA ("Not now") — 15 / w600 / textSecondary.
  final TextStyle permissionDismiss;

  /// Welcome gradient headline base — 28 / w800 / ink.
  final TextStyle welcomeHeadline;

  /// Welcome ShaderMask child — same metrics, white for blend.
  final TextStyle welcomeHeadlineMasked;

  /// Welcome body copy — 16 / w500 / textSecondary.
  final TextStyle welcomeSubtitle;

  /// Welcome secondary action — 15 / w600 / textSecondary.
  final TextStyle welcomeSecondaryAction;

  /// Welcome replay chip — 12 / w700 / pinkHot.
  final TextStyle welcomeReplayLabel;

  /// Splash tagline — 16 / w500 / textSecondary.
  final TextStyle splashTagline;

  /// Walkthrough title — 26 / w800 / ink.
  final TextStyle walkthroughTitle;

  /// Walkthrough subtitle — 14.5 / w500 / walkthroughMuted.
  final TextStyle walkthroughSubtitle;

  /// Walkthrough demo card label — 11.5 / w700 / ink.
  final TextStyle walkthroughDemoLabel;

  /// Walkthrough KEEP/DELETE stamp — 16 / w800; color applied per stamp.
  final TextStyle walkthroughSwipeStamp;

  /// Walkthrough hint row — 14 / w700 / ink.
  final TextStyle walkthroughHint;

  /// Module card title — 14 / w700 / ink.
  final TextStyle moduleCardTitle;

  /// Module card subtitle — 11 / w700 / muted ink.
  final TextStyle moduleCardSubtitle;

  /// Gradient primary CTA — 17 / w700 / white.
  final TextStyle primaryCta;

  /// Filled primary button (no gradient) — 15 / w700 / white.
  final TextStyle primaryButton;

  /// Status pill label — 10.5 / w700 / muted ink.
  final TextStyle statusPill;

  /// Segmented control selected segment — 13 / w600 / ink.
  final TextStyle segmentedLabelSelected;

  /// Segmented control unselected segment — 13 / w600 / muted ink.
  final TextStyle segmentedLabelUnselected;

  /// Swipe session stamp — 15 / w700; color applied per action.
  final TextStyle swipeStamp;

  /// Home progress ring center value — 34 / w800 / ink.
  final TextStyle homeProgressRingNumber;

  /// Home progress ring caption — 11 / w700 / walkthroughMuted.
  final TextStyle homeProgressRingCaption;

  /// Home progress side stat count — 22 / w800 / ink.
  final TextStyle homeProgressSideCount;

  /// Session summary kept/deleted count — 34 / w800.
  final TextStyle sessionSummaryStatCount;

  /// Streak hero count — 44 / w800 / ink.
  final TextStyle streakHeroNumber;

  /// Streak "Day Streak" label — 21 / w800 / ink.
  final TextStyle streakDayStreakLabel;

  /// Streak encouragement line — 13 / w500 / walkthroughMuted.
  final TextStyle streakKeepGoing;

  /// Streak weekday letter — 12 / w700 / walkthroughMuted.
  final TextStyle streakWeekdayLetter;

  /// Streak heatmap section meta — 11 / w600 / walkthroughMuted.
  final TextStyle streakHeatmapMeta;

  /// Streak stat card count — 20 / w800 / ink.
  final TextStyle streakStatCount;

  /// Streak stat card label — 11.5 / w700 / walkthroughMuted.
  final TextStyle streakStatLabel;

  /// Streak heatmap legend — 10 / w600 / walkthroughMuted.
  final TextStyle streakLegendLabel;

  static DecluttrTypography resolve({required DecluttrTheme brand}) {
    TextStyle sans(
      TextStyle base, {
      Color? color,
    }) {
      return GoogleFonts.plusJakartaSans(textStyle: base, color: color);
    }

    return DecluttrTypography(
      homeEyebrow: sans(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, height: 1.4, letterSpacing: 0),
        color: brand.pinkHot,
      ),
      homeHero: sans(
        const TextStyle(fontSize: 32, fontWeight: FontWeight.w700, height: 1.1, letterSpacing: -0.6),
        color: brand.ink,
      ),
      homeHeroAccent: sans(
        const TextStyle(fontSize: 32, fontWeight: FontWeight.w700, height: 1.1, letterSpacing: -0.6),
        color: brand.pinkHot,
      ),
      homeHeroSub: sans(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 1.45, letterSpacing: 0),
        color: brand.textSecondary,
      ),
      permissionTitle: sans(
        const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, height: 1.16, letterSpacing: -0.5),
        color: brand.ink,
      ),
      permissionSubtitle: sans(
        const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, height: 1.5),
        color: brand.textSecondary,
      ),
      permissionBullet: sans(
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 1.5),
        color: brand.textSecondary,
      ),
      permissionDismiss: sans(
        const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        color: brand.textSecondary,
      ),
      welcomeHeadline: sans(
        const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, height: 1.25, letterSpacing: -0.5),
        color: brand.ink,
      ),
      welcomeHeadlineMasked: sans(
        const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, height: 1.25, letterSpacing: -0.5),
        color: brand.white,
      ),
      welcomeSubtitle: sans(
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.55),
        color: brand.textSecondary,
      ),
      welcomeSecondaryAction: sans(
        const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        color: brand.textSecondary,
      ),
      welcomeReplayLabel: sans(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0),
        color: brand.pinkHot,
      ),
      splashTagline: sans(
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.5),
        color: brand.textSecondary,
      ),
      walkthroughTitle: sans(
        const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, height: 1.2, letterSpacing: -0.5),
        color: brand.ink,
      ),
      walkthroughSubtitle: sans(
        const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500),
        color: brand.walkthroughMuted,
      ),
      walkthroughDemoLabel: sans(
        const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, letterSpacing: 0),
        color: brand.ink,
      ),
      walkthroughSwipeStamp: sans(
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, height: 1.1, letterSpacing: 1),
      ),
      walkthroughHint: sans(
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        color: brand.ink,
      ),
      moduleCardTitle: sans(
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, height: 1.3),
        color: brand.ink,
      ),
      moduleCardSubtitle: sans(
        const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0),
        color: brand.inkA(0.65),
      ),
      primaryCta: sans(
        const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        color: brand.white,
      ),
      primaryButton: sans(
        const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        color: brand.white,
      ),
      statusPill: sans(
        const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700),
        color: brand.inkA(0.65),
      ),
      segmentedLabelSelected: sans(
        const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        color: brand.ink,
      ),
      segmentedLabelUnselected: sans(
        const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        color: brand.inkA(0.55),
      ),
      swipeStamp: sans(
        const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
      ),
      homeProgressRingNumber: sans(
        const TextStyle(fontSize: 34, fontWeight: FontWeight.w800, height: 1),
        color: brand.ink,
      ),
      homeProgressRingCaption: sans(
        const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, height: 1.15),
        color: brand.walkthroughMuted,
      ),
      homeProgressSideCount: sans(
        const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, height: 1),
        color: brand.ink,
      ),
      sessionSummaryStatCount: sans(
        const TextStyle(fontSize: 34, fontWeight: FontWeight.w800, height: 1),
        color: brand.ink,
      ),
      streakHeroNumber: sans(
        const TextStyle(fontSize: 44, fontWeight: FontWeight.w800, height: 1, letterSpacing: -1),
        color: brand.ink,
      ),
      streakDayStreakLabel: sans(
        const TextStyle(fontSize: 21, fontWeight: FontWeight.w800, height: 1.1),
        color: brand.ink,
      ),
      streakKeepGoing: sans(
        const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, height: 1.3),
        color: brand.walkthroughMuted,
      ),
      streakWeekdayLetter: sans(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, height: 1),
        color: brand.walkthroughMuted,
      ),
      streakHeatmapMeta: sans(
        const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, height: 1.2),
        color: brand.walkthroughMuted,
      ),
      streakStatCount: sans(
        const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, height: 1),
        color: brand.ink,
      ),
      streakStatLabel: sans(
        const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, height: 1.2),
        color: brand.walkthroughMuted,
      ),
      streakLegendLabel: sans(
        const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, height: 1),
        color: brand.walkthroughMuted,
      ),
    );
  }

  @override
  DecluttrTypography copyWith({
    TextStyle? homeEyebrow,
    TextStyle? homeHero,
    TextStyle? homeHeroAccent,
    TextStyle? homeHeroSub,
    TextStyle? permissionTitle,
    TextStyle? permissionSubtitle,
    TextStyle? permissionBullet,
    TextStyle? permissionDismiss,
    TextStyle? welcomeHeadline,
    TextStyle? welcomeHeadlineMasked,
    TextStyle? welcomeSubtitle,
    TextStyle? welcomeSecondaryAction,
    TextStyle? welcomeReplayLabel,
    TextStyle? splashTagline,
    TextStyle? walkthroughTitle,
    TextStyle? walkthroughSubtitle,
    TextStyle? walkthroughDemoLabel,
    TextStyle? walkthroughSwipeStamp,
    TextStyle? walkthroughHint,
    TextStyle? moduleCardTitle,
    TextStyle? moduleCardSubtitle,
    TextStyle? primaryCta,
    TextStyle? primaryButton,
    TextStyle? statusPill,
    TextStyle? segmentedLabelSelected,
    TextStyle? segmentedLabelUnselected,
    TextStyle? swipeStamp,
    TextStyle? homeProgressRingNumber,
    TextStyle? homeProgressRingCaption,
    TextStyle? homeProgressSideCount,
    TextStyle? sessionSummaryStatCount,
    TextStyle? streakHeroNumber,
    TextStyle? streakDayStreakLabel,
    TextStyle? streakKeepGoing,
    TextStyle? streakWeekdayLetter,
    TextStyle? streakHeatmapMeta,
    TextStyle? streakStatCount,
    TextStyle? streakStatLabel,
    TextStyle? streakLegendLabel,
  }) {
    return DecluttrTypography(
      homeEyebrow: homeEyebrow ?? this.homeEyebrow,
      homeHero: homeHero ?? this.homeHero,
      homeHeroAccent: homeHeroAccent ?? this.homeHeroAccent,
      homeHeroSub: homeHeroSub ?? this.homeHeroSub,
      permissionTitle: permissionTitle ?? this.permissionTitle,
      permissionSubtitle: permissionSubtitle ?? this.permissionSubtitle,
      permissionBullet: permissionBullet ?? this.permissionBullet,
      permissionDismiss: permissionDismiss ?? this.permissionDismiss,
      welcomeHeadline: welcomeHeadline ?? this.welcomeHeadline,
      welcomeHeadlineMasked: welcomeHeadlineMasked ?? this.welcomeHeadlineMasked,
      welcomeSubtitle: welcomeSubtitle ?? this.welcomeSubtitle,
      welcomeSecondaryAction: welcomeSecondaryAction ?? this.welcomeSecondaryAction,
      welcomeReplayLabel: welcomeReplayLabel ?? this.welcomeReplayLabel,
      splashTagline: splashTagline ?? this.splashTagline,
      walkthroughTitle: walkthroughTitle ?? this.walkthroughTitle,
      walkthroughSubtitle: walkthroughSubtitle ?? this.walkthroughSubtitle,
      walkthroughDemoLabel: walkthroughDemoLabel ?? this.walkthroughDemoLabel,
      walkthroughSwipeStamp: walkthroughSwipeStamp ?? this.walkthroughSwipeStamp,
      walkthroughHint: walkthroughHint ?? this.walkthroughHint,
      moduleCardTitle: moduleCardTitle ?? this.moduleCardTitle,
      moduleCardSubtitle: moduleCardSubtitle ?? this.moduleCardSubtitle,
      primaryCta: primaryCta ?? this.primaryCta,
      primaryButton: primaryButton ?? this.primaryButton,
      statusPill: statusPill ?? this.statusPill,
      segmentedLabelSelected: segmentedLabelSelected ?? this.segmentedLabelSelected,
      segmentedLabelUnselected: segmentedLabelUnselected ?? this.segmentedLabelUnselected,
      swipeStamp: swipeStamp ?? this.swipeStamp,
      homeProgressRingNumber: homeProgressRingNumber ?? this.homeProgressRingNumber,
      homeProgressRingCaption: homeProgressRingCaption ?? this.homeProgressRingCaption,
      homeProgressSideCount: homeProgressSideCount ?? this.homeProgressSideCount,
      sessionSummaryStatCount: sessionSummaryStatCount ?? this.sessionSummaryStatCount,
      streakHeroNumber: streakHeroNumber ?? this.streakHeroNumber,
      streakDayStreakLabel: streakDayStreakLabel ?? this.streakDayStreakLabel,
      streakKeepGoing: streakKeepGoing ?? this.streakKeepGoing,
      streakWeekdayLetter: streakWeekdayLetter ?? this.streakWeekdayLetter,
      streakHeatmapMeta: streakHeatmapMeta ?? this.streakHeatmapMeta,
      streakStatCount: streakStatCount ?? this.streakStatCount,
      streakStatLabel: streakStatLabel ?? this.streakStatLabel,
      streakLegendLabel: streakLegendLabel ?? this.streakLegendLabel,
    );
  }

  static TextStyle _blend(TextStyle a, TextStyle b, double t) {
    return TextStyle.lerp(a, b, t) ?? (t < 0.5 ? a : b);
  }

  static TextStyle _styleFrom(
    DecluttrTypography other,
    TextStyle Function(DecluttrTypography) pick,
    TextStyle fallback,
  ) {
    try {
      return pick(other);
    } catch (_) {
      return fallback;
    }
  }

  @override
  DecluttrTypography lerp(ThemeExtension<DecluttrTypography>? other, double t) {
    if (other is! DecluttrTypography) return this;
    final o = other;
    return DecluttrTypography(
      homeEyebrow: _blend(homeEyebrow, _styleFrom(o, (x) => x.homeEyebrow, homeEyebrow), t),
      homeHero: _blend(homeHero, _styleFrom(o, (x) => x.homeHero, homeHero), t),
      homeHeroAccent: _blend(homeHeroAccent, _styleFrom(o, (x) => x.homeHeroAccent, homeHeroAccent), t),
      homeHeroSub: _blend(homeHeroSub, _styleFrom(o, (x) => x.homeHeroSub, homeHeroSub), t),
      permissionTitle: _blend(permissionTitle, _styleFrom(o, (x) => x.permissionTitle, permissionTitle), t),
      permissionSubtitle: _blend(
        permissionSubtitle,
        _styleFrom(o, (x) => x.permissionSubtitle, permissionSubtitle),
        t,
      ),
      permissionBullet: _blend(permissionBullet, _styleFrom(o, (x) => x.permissionBullet, permissionBullet), t),
      permissionDismiss: _blend(
        permissionDismiss,
        _styleFrom(o, (x) => x.permissionDismiss, permissionDismiss),
        t,
      ),
      welcomeHeadline: _blend(
        welcomeHeadline,
        _styleFrom(o, (x) => x.welcomeHeadline, welcomeHeadline),
        t,
      ),
      welcomeHeadlineMasked: _blend(
        welcomeHeadlineMasked,
        _styleFrom(o, (x) => x.welcomeHeadlineMasked, welcomeHeadlineMasked),
        t,
      ),
      welcomeSubtitle: _blend(welcomeSubtitle, _styleFrom(o, (x) => x.welcomeSubtitle, welcomeSubtitle), t),
      welcomeSecondaryAction: _blend(
        welcomeSecondaryAction,
        _styleFrom(o, (x) => x.welcomeSecondaryAction, welcomeSecondaryAction),
        t,
      ),
      welcomeReplayLabel: _blend(
        welcomeReplayLabel,
        _styleFrom(o, (x) => x.welcomeReplayLabel, welcomeReplayLabel),
        t,
      ),
      splashTagline: _blend(splashTagline, _styleFrom(o, (x) => x.splashTagline, splashTagline), t),
      walkthroughTitle: _blend(walkthroughTitle, _styleFrom(o, (x) => x.walkthroughTitle, walkthroughTitle), t),
      walkthroughSubtitle: _blend(
        walkthroughSubtitle,
        _styleFrom(o, (x) => x.walkthroughSubtitle, walkthroughSubtitle),
        t,
      ),
      walkthroughDemoLabel: _blend(
        walkthroughDemoLabel,
        _styleFrom(o, (x) => x.walkthroughDemoLabel, walkthroughDemoLabel),
        t,
      ),
      walkthroughSwipeStamp: _blend(
        walkthroughSwipeStamp,
        _styleFrom(o, (x) => x.walkthroughSwipeStamp, walkthroughSwipeStamp),
        t,
      ),
      walkthroughHint: _blend(walkthroughHint, _styleFrom(o, (x) => x.walkthroughHint, walkthroughHint), t),
      moduleCardTitle: _blend(moduleCardTitle, _styleFrom(o, (x) => x.moduleCardTitle, moduleCardTitle), t),
      moduleCardSubtitle: _blend(
        moduleCardSubtitle,
        _styleFrom(o, (x) => x.moduleCardSubtitle, moduleCardSubtitle),
        t,
      ),
      primaryCta: _blend(primaryCta, _styleFrom(o, (x) => x.primaryCta, primaryCta), t),
      primaryButton: _blend(primaryButton, _styleFrom(o, (x) => x.primaryButton, primaryButton), t),
      statusPill: _blend(statusPill, _styleFrom(o, (x) => x.statusPill, statusPill), t),
      segmentedLabelSelected: _blend(
        segmentedLabelSelected,
        _styleFrom(o, (x) => x.segmentedLabelSelected, segmentedLabelSelected),
        t,
      ),
      segmentedLabelUnselected: _blend(
        segmentedLabelUnselected,
        _styleFrom(o, (x) => x.segmentedLabelUnselected, segmentedLabelUnselected),
        t,
      ),
      swipeStamp: _blend(swipeStamp, _styleFrom(o, (x) => x.swipeStamp, swipeStamp), t),
      homeProgressRingNumber: _blend(
        homeProgressRingNumber,
        _styleFrom(o, (x) => x.homeProgressRingNumber, homeProgressRingNumber),
        t,
      ),
      homeProgressRingCaption: _blend(
        homeProgressRingCaption,
        _styleFrom(o, (x) => x.homeProgressRingCaption, homeProgressRingCaption),
        t,
      ),
      homeProgressSideCount: _blend(
        homeProgressSideCount,
        _styleFrom(o, (x) => x.homeProgressSideCount, homeProgressSideCount),
        t,
      ),
      sessionSummaryStatCount: _blend(
        sessionSummaryStatCount,
        _styleFrom(o, (x) => x.sessionSummaryStatCount, sessionSummaryStatCount),
        t,
      ),
      streakHeroNumber: _blend(
        streakHeroNumber,
        _styleFrom(o, (x) => x.streakHeroNumber, streakHeroNumber),
        t,
      ),
      streakDayStreakLabel: _blend(
        streakDayStreakLabel,
        _styleFrom(o, (x) => x.streakDayStreakLabel, streakDayStreakLabel),
        t,
      ),
      streakKeepGoing: _blend(
        streakKeepGoing,
        _styleFrom(o, (x) => x.streakKeepGoing, streakKeepGoing),
        t,
      ),
      streakWeekdayLetter: _blend(
        streakWeekdayLetter,
        _styleFrom(o, (x) => x.streakWeekdayLetter, streakWeekdayLetter),
        t,
      ),
      streakHeatmapMeta: _blend(
        streakHeatmapMeta,
        _styleFrom(o, (x) => x.streakHeatmapMeta, streakHeatmapMeta),
        t,
      ),
      streakStatCount: _blend(
        streakStatCount,
        _styleFrom(o, (x) => x.streakStatCount, streakStatCount),
        t,
      ),
      streakStatLabel: _blend(
        streakStatLabel,
        _styleFrom(o, (x) => x.streakStatLabel, streakStatLabel),
        t,
      ),
      streakLegendLabel: _blend(
        streakLegendLabel,
        _styleFrom(o, (x) => x.streakLegendLabel, streakLegendLabel),
        t,
      ),
    );
  }
}

extension DecluttrTypographyBuildContext on BuildContext {
  DecluttrTypography get decluttrTypography {
    final theme = Theme.of(this);
    final brand =
        theme.extension<DecluttrTheme>() ??
        (theme.brightness == Brightness.dark ? DecluttrTheme.dark : DecluttrTheme.light);
    final ext = theme.extension<DecluttrTypography>();
    if (ext != null) {
      try {
        ext.homeHero;
        return ext;
      } catch (_) {
        // Hot reload can leave stale instances missing newly added fields.
      }
    }
    return DecluttrTypography.resolve(brand: brand);
  }
}
