import 'package:flutter/material.dart';
import 'package:mangatek_flutter/core/theme/constants.theme.dart';
import 'package:mangatek_flutter/generated/fonts.gen.dart';

import 'app_colors.dart' as colors;
import 'color.theme.dart';

/// Provides [ThemeData] for both light and dark themes.
/// Usage in [MaterialApp]:
/// ```dart
/// theme: AppTheme.lightTheme,
/// darkTheme: AppTheme.darkTheme,
/// themeMode: ThemeMode.system,
/// ```
class AppTheme {
  const AppTheme._();

  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData get lightTheme => _buildTheme(Brightness.light);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final primary = isDark ? colors.primaryDark : colors.primaryLight;
    final secondary = isDark ? colors.secondaryDark : colors.secondaryLight;
    final background = isDark ? colors.backgroundDark : colors.backgroundLight;
    final surface = isDark ? colors.surfaceDark : colors.surfaceLight;
    final surfaceVariant = isDark ? colors.surfaceVariantDark : colors.surfaceVariantLight;
    final onBackground = isDark ? colors.onBackgroundDark : colors.onBackgroundLight;
    final onSurface = isDark ? colors.onSurfaceDark : colors.onSurfaceLight;
    final onSurfaceVariant = isDark ? colors.onSurfaceVariantDark : colors.onSurfaceVariantLight;
    final error = isDark ? colors.errorDark : colors.errorLight;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onBackground,
      secondary: secondary,
      onSecondary: onBackground,
      tertiary: colors.tertiary,
      onTertiary: onBackground,
      error: error,
      onError: colors.onError,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      textTheme: _buildTextTheme(),
      extensions: [
        ColorTheme(
          primary: primary,
          secondary: secondary,
          tertiary: colors.tertiary,
          background: background,
          surface: surface,
          surfaceVariant: surfaceVariant,
          onBackground: onBackground,
          onSurface: onSurface,
          onSurfaceVariant: onSurfaceVariant,
          error: error,
          onError: colors.onError,
        ),
        ConstantsTheme(),
      ],
    );
  }

  static TextTheme _buildTextTheme() {
    TextStyle style(double size, FontWeight weight) =>
        TextStyle(fontFamily: FontFamily.exo2, fontSize: size, fontWeight: weight);

    return TextTheme(
      displayLarge: style(57, FontWeight.w700),
      displayMedium: style(45, FontWeight.w700),
      displaySmall: style(36, FontWeight.w700),
      headlineLarge: style(32, FontWeight.w500),
      headlineMedium: style(28, FontWeight.w500),
      headlineSmall: style(24, FontWeight.w500),
      titleLarge: style(22, FontWeight.w500),
      titleMedium: style(16, FontWeight.w500),
      titleSmall: style(14, FontWeight.w500),
      bodyLarge: style(16, FontWeight.w400),
      bodyMedium: style(14, FontWeight.w400),
      bodySmall: style(12, FontWeight.w400),
      labelLarge: style(14, FontWeight.w500),
      labelMedium: style(12, FontWeight.w500),
      labelSmall: style(11, FontWeight.w500),
    );
  }
}
