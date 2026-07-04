import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_text.dart';
import 'decluttr_theme.dart';
import 'decluttr_typography.dart';

ThemeData buildLightTheme() {
  return _buildTheme(brand: DecluttrTheme.light, brightness: Brightness.light);
}

ThemeData buildDarkTheme() {
  return _buildTheme(brand: DecluttrTheme.dark, brightness: Brightness.dark);
}

ThemeData _buildTheme({
  required DecluttrTheme brand,
  required Brightness brightness,
}) {
  final textTheme = AppText.buildTextTheme(brand);
  final isDark = brightness == Brightness.dark;

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    scaffoldBackgroundColor: brand.canvas,
    extensions: [
      brand,
      DecluttrTypography.resolve(brand: brand),
    ],
    colorScheme: isDark
        ? ColorScheme.dark(
            primary: brand.white,
            onPrimary: brand.ink,
            secondary: brand.pinkHot,
            surface: brand.surfaceCard,
            onSurface: brand.white,
            error: brand.destructive,
          )
        : ColorScheme.light(
            primary: brand.ink,
            onPrimary: brand.white,
            secondary: brand.pinkHot,
            surface: brand.white,
            onSurface: brand.ink,
            error: brand.destructive,
          ),
    textTheme: isDark
        ? textTheme.apply(bodyColor: brand.white, displayColor: brand.white)
        : textTheme,
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: brand.canvas,
      foregroundColor: brand.ink,
      systemOverlayStyle:
          isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: isDark ? brand.white : brand.ink,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: brand.divider,
      thickness: 1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: brand.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(brand.radiusSm),
        borderSide: BorderSide(color: brand.inkA(0.08)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(brand.radiusSm),
        borderSide: BorderSide(color: brand.inkA(0.08)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(brand.radiusSm),
        borderSide: BorderSide(color: brand.pinkHot, width: 1.5),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: brand.x4,
        vertical: 14,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(brand.white),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return brand.success;
        }
        return brand.inkA(0.15);
      }),
    ),
  );
}
