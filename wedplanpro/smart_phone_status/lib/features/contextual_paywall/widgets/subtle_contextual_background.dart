import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';

class SubtleContextualBackground extends StatelessWidget {
  const SubtleContextualBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ContextualGridPainter(),
    );
  }
}

class _ContextualGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textMuted.withOpacity(0.045)
      ..strokeWidth = 1;
    const spacing = 34.0;
    for (var x = 0.0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
