import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class TrendChartCard extends StatelessWidget {
  const TrendChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
      ),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        border: Border.all(
          color: AppColors.neonCyan.withOpacity(0.45),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonCyan.withOpacity(0.16),
            blurRadius: 12,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _ChartPainter(),
            ),
          ),
          Positioned(
            right: 12,
            top: 6,
            child: Row(
              children: [
                Text(
                  'LIVE_ANALYSIS',
                  style: AppText.hudLabel.copyWith(
                    fontSize: 10.5,
                    letterSpacing: 2,
                    color: AppColors.neonCyan.withOpacity(0.8),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.neonCyan,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            top: 26,
            child: Text(
              'FUTURE',
              style: AppText.hudLabel.copyWith(
                fontSize: 10,
                letterSpacing: 2,
                color: AppColors.textMuted.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: Text(
              'NOW',
              style: AppText.hudLabel.copyWith(
                fontSize: 10,
                letterSpacing: 2,
                color: AppColors.neonCyan.withOpacity(0.8),
              ),
            ),
          ),
          const _CornerAccents(),
        ],
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors.neonCyan
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final glowPaint = Paint()
      ..color = AppColors.neonCyan.withOpacity(0.35)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);

    final points = [
      Offset(0, size.height * 0.72),
      Offset(size.width * 0.25, size.height * 0.7),
      Offset(size.width * 0.5, size.height * 0.55),
      Offset(size.width * 0.7, size.height * 0.38),
      Offset(size.width * 0.95, size.height * 0.22),
    ];

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      final prev = points[i - 1];
      final current = points[i];
      final control = Offset(
        (prev.dx + current.dx) / 2,
        (prev.dy + current.dy) / 2,
      );
      path.quadraticBezierTo(prev.dx, prev.dy, control.dx, control.dy);
    }
    path.lineTo(points.last.dx, points.last.dy);

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, linePaint);

    canvas.drawCircle(
      points[2],
      4,
      Paint()
        ..color = AppColors.neonCyan
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CornerAccents extends StatelessWidget {
  const _CornerAccents();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: CustomPaint(
          painter: _CornerPainter(),
        ),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.neonCyan.withOpacity(0.5)
      ..strokeWidth = 1;
    const len = 10.0;

    canvas.drawLine(const Offset(0, 0), const Offset(len, 0), paint);
    canvas.drawLine(const Offset(0, 0), const Offset(0, len), paint);
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width - len, 0), paint);
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width, len), paint);
    canvas.drawLine(
        Offset(0, size.height), Offset(len, size.height), paint);
    canvas.drawLine(
        Offset(0, size.height), Offset(0, size.height - len), paint);
    canvas.drawLine(
        Offset(size.width, size.height),
        Offset(size.width - len, size.height),
        paint);
    canvas.drawLine(
        Offset(size.width, size.height),
        Offset(size.width, size.height - len),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
