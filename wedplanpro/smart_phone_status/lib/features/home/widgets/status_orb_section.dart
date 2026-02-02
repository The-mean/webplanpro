import 'dart:math';

import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_shadows.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class StatusOrbSection extends StatefulWidget {
  const StatusOrbSection({super.key, required this.score});

  final int score;

  @override
  State<StatusOrbSection> createState() => _StatusOrbSectionState();
}

class _StatusOrbSectionState extends State<StatusOrbSection>
    with TickerProviderStateMixin {
  late final AnimationController _rotateController;
  late final AnimationController _breathController;
  late final Animation<double> _breathAnimation;

  @override
  void initState() {
    super.initState();
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 28),
    )..repeat();
    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);
    _breathAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _rotateController.dispose();
    _breathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxSize = constraints.maxWidth.clamp(0, 320);
        final outerSize = maxSize.toDouble();
        final dashedSize = outerSize * 0.86;
        final innerSize = outerSize * 0.72;
        final coreSize = outerSize * 0.46;
        final sectionHeight = outerSize + 40;

        return SizedBox(
          height: sectionHeight,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _CrosshairPainter(),
                ),
              ),
              Container(
                width: outerSize,
                height: outerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.neonCyan.withOpacity(0.25),
                    width: 1,
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _rotateController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotateController.value * 2 * pi,
                    child: child,
                  );
                },
                child: CustomPaint(
                  size: Size(dashedSize, dashedSize),
                  painter: _DashedRingPainter(
                    color: AppColors.neonCyan.withOpacity(0.55),
                    strokeWidth: 1,
                    dashCount: 48,
                    dashRatio: 0.55,
                  ),
                ),
              ),
              Container(
                width: innerSize,
                height: innerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.neonCyan.withOpacity(0.45),
                    width: 1.2,
                  ),
                ),
              ),
              ScaleTransition(
                scale: _breathAnimation,
                child: Container(
                  width: coreSize,
                  height: coreSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.neonCyan.withOpacity(0.08),
                    border: Border.all(
                      color: AppColors.neonCyan.withOpacity(0.85),
                      width: 2,
                    ),
                    boxShadow: AppShadows.neonGlow,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.score.toString(),
                    style: AppText.scoreNumber.copyWith(
                      fontSize: 64,
                      color: AppColors.neonCyan,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'SCORE',
                    style: AppText.hudLabel.copyWith(
                      color: AppColors.neonCyan.withOpacity(0.7),
                      letterSpacing: 3.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CrosshairPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.cardBorder
      ..strokeWidth = 1;
    final center = size.center(Offset.zero);
    canvas.drawLine(
      Offset(0, center.dy),
      Offset(size.width, center.dy),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx, 0),
      Offset(center.dx, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DashedRingPainter extends CustomPainter {
  _DashedRingPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashCount,
    required this.dashRatio,
  });

  final Color color;
  final double strokeWidth;
  final int dashCount;
  final double dashRatio;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final sweep = 2 * pi / dashCount;
    for (var i = 0; i < dashCount; i++) {
      final start = i * sweep;
      canvas.drawArc(rect, start, sweep * dashRatio, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRingPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashCount != dashCount ||
        oldDelegate.dashRatio != dashRatio;
  }
}
