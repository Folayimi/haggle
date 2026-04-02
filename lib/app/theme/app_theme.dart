import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme(TextTheme textTheme) {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.accent,
      primaryContainer: AppColors.accent,
      onPrimaryContainer: AppColors.dark,
      secondary: AppColors.secondary,
      onSecondary: AppColors.accent,
      secondaryContainer: AppColors.accent,
      onSecondaryContainer: AppColors.dark,
      tertiary: AppColors.warning,
      onTertiary: AppColors.dark,
      tertiaryContainer: AppColors.accent,
      onTertiaryContainer: AppColors.dark,
      error: AppColors.danger,
      onError: AppColors.accent,
      errorContainer: AppColors.accent,
      onErrorContainer: AppColors.dark,
      background: AppColors.lightBackground,
      onBackground: AppColors.dark,
      surface: AppColors.lightSurface,
      onSurface: AppColors.dark,
      surfaceVariant: AppColors.neutral,
      onSurfaceVariant: AppColors.dark,
      outline: AppColors.dark.withOpacity(0.2),
      outlineVariant: AppColors.dark.withOpacity(0.12),
      shadow: AppColors.dark.withOpacity(0.25),
      scrim: AppColors.dark.withOpacity(0.4),
      inverseSurface: AppColors.dark,
      onInverseSurface: AppColors.accent,
      inversePrimary: AppColors.primary,
      surfaceTint: AppColors.primary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.lightBackground,
      dividerColor: AppColors.dark.withOpacity(0.08),
      iconTheme: const IconThemeData(color: AppColors.dark),
      textTheme: textTheme.apply(
        bodyColor: AppColors.dark,
        displayColor: AppColors.dark,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.lightBackground,
        foregroundColor: AppColors.dark,
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.neutral,
        selectedColor: AppColors.primary.withOpacity(0.15),
        labelStyle: textTheme.labelMedium?.copyWith(color: AppColors.dark),
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(color: AppColors.dark),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.accent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.accent,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }

  static ThemeData darkTheme(TextTheme textTheme) {
    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.dark,
      primaryContainer: AppColors.secondary,
      onPrimaryContainer: AppColors.accent,
      secondary: AppColors.secondary,
      onSecondary: AppColors.accent,
      secondaryContainer: AppColors.dark,
      onSecondaryContainer: AppColors.accent,
      tertiary: AppColors.warning,
      onTertiary: AppColors.dark,
      tertiaryContainer: AppColors.dark,
      onTertiaryContainer: AppColors.accent,
      error: AppColors.danger,
      onError: AppColors.accent,
      errorContainer: AppColors.dark,
      onErrorContainer: AppColors.accent,
      background: AppColors.darkBackground,
      onBackground: AppColors.neutral,
      surface: AppColors.darkSurface,
      onSurface: AppColors.neutral,
      surfaceVariant: AppColors.dark,
      onSurfaceVariant: AppColors.neutral,
      outline: AppColors.neutral.withOpacity(0.2),
      outlineVariant: AppColors.neutral.withOpacity(0.12),
      shadow: AppColors.dark.withOpacity(0.6),
      scrim: AppColors.dark.withOpacity(0.6),
      inverseSurface: AppColors.neutral,
      onInverseSurface: AppColors.dark,
      inversePrimary: AppColors.primary,
      surfaceTint: AppColors.primary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      dividerColor: AppColors.neutral.withOpacity(0.08),
      iconTheme: const IconThemeData(color: AppColors.neutral),
      textTheme: textTheme.apply(
        bodyColor: AppColors.neutral,
        displayColor: AppColors.neutral,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.neutral,
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedColor: AppColors.primary.withOpacity(0.25),
        labelStyle: textTheme.labelMedium?.copyWith(color: AppColors.neutral),
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(color: AppColors.neutral),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.accent,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}
