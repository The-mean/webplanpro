import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppText {
  static TextStyle get title => GoogleFonts.spaceGrotesk(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get hudLabel => GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 2.2,
        color: AppColors.textMuted,
      );

  static TextStyle get scoreNumber => GoogleFonts.spaceGrotesk(
        fontSize: 48,
        fontWeight: FontWeight.w300,
        color: AppColors.neonCyan,
      );

  static TextStyle get bodyMuted => GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
      );
}
