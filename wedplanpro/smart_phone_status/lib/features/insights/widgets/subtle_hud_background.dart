import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';

class SubtleHudBackground extends StatelessWidget {
  const SubtleHudBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HudGridPainter(),
    );
  }
}

class _HudGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.neonCyan.withOpacity(0.05)
      ..style = PaintingStyle.fill;
    const spacing = 28.0;
    const radius = 1.2;
    for (var y = spacing / 2; y < size.height; y += spacing) {
      for (var x = spacing / 2; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
