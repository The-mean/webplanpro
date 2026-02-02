import 'dart:math';

import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';

class OrbVisualization extends StatelessWidget {
  const OrbVisualization({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(260, 260),
            painter: _OrbRingsPainter(),
          ),
          CustomPaint(
            size: const Size(200, 200),
            painter: _DotSpherePainter(),
          ),
          Positioned(
            right: 22,
            child: Text(
              'SCN_01',
              style: const TextStyle(
                color: AppColors.neonCyan,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
          ),
          Positioned(
            left: 24,
            top: 150,
            child: Text(
              'V.2.4',
              style: TextStyle(
                color: AppColors.neonCyan.withOpacity(0.8),
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrbRingsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerPaint = Paint()
      ..color = AppColors.neonCyan.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final dashedPaint = Paint()
      ..color = AppColors.neonCyan.withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, size.width * 0.42, outerPaint);
    _drawDashedCircle(
      canvas,
      center,
      size.width * 0.48,
      dashedPaint,
    );
  }

  void _drawDashedCircle(
    Canvas canvas,
    Offset center,
    double radius,
    Paint paint,
  ) {
    const dashCount = 44;
    const dashRatio = 0.55;
    final sweep = 2 * pi / dashCount;
    final rect = Rect.fromCircle(center: center, radius: radius);
    for (var i = 0; i < dashCount; i++) {
      final start = i * sweep;
      canvas.drawArc(rect, start, sweep * dashRatio, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DotSpherePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final dotPaint = Paint()
      ..color = AppColors.neonCyan.withOpacity(0.55)
      ..style = PaintingStyle.fill;
    for (double y = -radius; y <= radius; y += 4) {
      final rowRadius = sqrt(radius * radius - y * y);
      for (double x = -rowRadius; x <= rowRadius; x += 6) {
        final depth = 1 - (x.abs() / radius);
        final sizeFactor = 1.2 * depth + 0.6;
        dotPaint.color = AppColors.neonCyan.withOpacity(0.2 + 0.4 * depth);
        canvas.drawCircle(
          Offset(center.dx + x, center.dy + y),
          sizeFactor,
          dotPaint,
        );
      }
    }
    canvas.drawCircle(
      Offset(center.dx, center.dy + radius * 0.45),
      36,
      Paint()
        ..color = AppColors.neonCyan.withOpacity(0.2)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
