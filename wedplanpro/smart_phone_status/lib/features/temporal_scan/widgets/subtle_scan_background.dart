import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';

class SubtleScanBackground extends StatelessWidget {
  const SubtleScanBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ScanGridPainter(),
    );
  }
}

class _ScanGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.textMuted.withOpacity(0.08)
      ..strokeWidth = 1;
    const spacing = 36.0;

    for (var x = 0.0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (var y = 0.0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
