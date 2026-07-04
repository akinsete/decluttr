import 'package:flutter/material.dart';

/// Raw sRGB tokens from DESIGN_SYSTEM.md — used only when defining
/// [DecluttrTheme.light] / [DecluttrTheme.dark] in [decluttr_theme.dart].
abstract final class DecluttrThemeColors {
  static const canvas = Color(0xFFFBF6ED);
  static const canvasAlt = Color(0xFFFAF7F2);
  static const surfaceCard = Color(0xFFF4EEE2);
  static const white = Color(0xFFFFFFFF);
  static const divider = Color(0x141A1A1A);
  static const ink = Color(0xFF1A1A1A);

  static const blue = Color(0xFF8FD0FF);
  static const pink = Color(0xFFFF9EC0);
  static const pinkHot = Color(0xFFF84F93);
  static const lavender = Color(0xFFCBB8FF);
  static const yellow = Color(0xFFFFD666);
  static const mint = Color(0xFFA9E4B8);

  static const success = Color(0xFF4CAF6B);
  static const successText = Color(0xFF2E8B4F);
  static const destructive = Color(0xFFE85B4D);
  static const destructiveStrong = Color(0xFFC0392B);
  static const destructiveText = Color(0xFFA83A2E);
  static const iosSystemBlue = Color(0xFF0B84FF);
  static const textSecondary = Color(0xFF6E6E73);
  static const walkthroughMuted = Color(0xFF8A8078);
  static const walkthroughKeep = Color(0xFF34C77B);
  static const walkthroughDelete = Color(0xFFFF4F6D);
  static const walkthroughTap = Color(0xFF3B93F5);

  static const streakFill = Color(0xFFFFF6FA);
  static const streakBorder = Color(0xFFF6DCEA);
  static const errorCircle = Color(0xFFFFEDE7);
  static const errorIcon = Color(0xFFFF7A59);
  static const dockInactive = Color(0xFFB7ADA4);

  static const darkCanvas = Color(0xFF1A1816);
  static const darkSurface = Color(0xFF2A2622);
}
