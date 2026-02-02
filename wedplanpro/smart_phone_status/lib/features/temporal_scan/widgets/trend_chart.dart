import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';

class TrendChart extends StatelessWidget {
  const TrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.6,
      child: CustomPaint(
        painter: _TrendPainter(),
      ),
    );
  }
}

class _TrendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.textMuted.withOpacity(0.08)
      ..strokeWidth = 1;
    final linePaint = Paint()
      ..color = AppColors.neonCyan
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;
    final glowPaint = Paint()
      ..color = AppColors.neonCyan.withOpacity(0.25)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final gridY = size.height * 0.55;
    canvas.drawLine(Offset(0, gridY), Offset(size.width, gridY), gridPaint);
    canvas.drawLine(
      Offset(0, size.height - 1),
      Offset(size.width, size.height - 1),
      gridPaint,
    );

    final points = [
      Offset(0, size.height * 0.85),
      Offset(size.width * 0.18, size.height * 0.82),
      Offset(size.width * 0.34, size.height * 0.72),
      Offset(size.width * 0.52, size.height * 0.66),
      Offset(size.width * 0.68, size.height * 0.58),
      Offset(size.width * 0.82, size.height * 0.52),
      Offset(size.width, size.height * 0.38),
    ];

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      final prev = points[i - 1];
      final current = points[i];
      final controlPoint = Offset(
        (prev.dx + current.dx) / 2,
        (prev.dy + current.dy) / 2,
      );
      path.quadraticBezierTo(
        prev.dx,
        prev.dy,
        controlPoint.dx,
        controlPoint.dy,
      );
    }
    path.lineTo(points.last.dx, points.last.dy);

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, linePaint);

    canvas.drawCircle(
      points.last,
      5,
      Paint()
        ..color = AppColors.neonCyan
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
