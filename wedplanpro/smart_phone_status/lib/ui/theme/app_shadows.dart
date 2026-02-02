import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppShadows {
  static const List<BoxShadow> neonGlow = [
    BoxShadow(
      color: Color(0x5500F2FF),
      blurRadius: 18,
      spreadRadius: 1,
      offset: Offset(0, 0),
    ),
    BoxShadow(
      color: Color(0x2200F2FF),
      blurRadius: 36,
      spreadRadius: 6,
      offset: Offset(0, 0),
    ),
  ];

  static const List<BoxShadow> softCard = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 14,
      offset: Offset(0, 6),
    ),
  ];

  static const BoxShadow thinGlow = BoxShadow(
    color: AppColors.cardBorder,
    blurRadius: 8,
    spreadRadius: 0,
    offset: Offset(0, 0),
  );
}
