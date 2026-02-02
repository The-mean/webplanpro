import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class Sparkline extends StatelessWidget {
  const Sparkline({super.key, required this.values});

  final List<int> values;

  @override
  Widget build(BuildContext context) {
    if (values.length < 2) {
      return Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimens.radius),
          border: Border.all(color: AppColors.border),
        ),
      );
    }
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: CustomPaint(
        painter: _SparklinePainter(values),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter(this.values);

  final List<int> values;

  @override
  void paint(Canvas canvas, Size size) {
    final minVal = values.reduce((a, b) => a < b ? a : b).toDouble();
    final maxVal = values.reduce((a, b) => a > b ? a : b).toDouble();
    final range = (maxVal - minVal).clamp(1, 100);

    final paint = Paint()
      ..color = AppColors.neon
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final x = size.width * (i / (values.length - 1));
      final normalized = (values[i] - minVal) / range;
      final y = size.height - normalized * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final glowPaint = Paint()
      ..color = AppColors.neon.withOpacity(0.4)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return oldDelegate.values != values;
  }
}
