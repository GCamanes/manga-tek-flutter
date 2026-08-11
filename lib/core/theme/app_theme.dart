import 'package:flutter/material.dart';

import 'app_colors.dart' as colors;
import 'color_theme.dart';

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
      ],
    );
  }
}
