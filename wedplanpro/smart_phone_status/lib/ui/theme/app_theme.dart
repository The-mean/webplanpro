import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text.dart';

class AppTheme {
  static ThemeData dark() {
    final colorScheme = const ColorScheme.dark(
      primary: AppColors.neonCyan,
      secondary: AppColors.neonCyan,
      background: AppColors.background,
      surface: AppColors.card,
    );

    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      cardColor: AppColors.card,
      dividerColor: AppColors.cardBorder,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardTheme(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          side: const BorderSide(color: AppColors.cardBorder),
        ),
      ),
      textTheme: TextTheme(
        titleLarge: AppText.title,
        labelSmall: AppText.hudLabel,
        displayLarge: AppText.scoreNumber,
        bodyMedium: AppText.bodyMuted,
      ),
    );
  }
}
