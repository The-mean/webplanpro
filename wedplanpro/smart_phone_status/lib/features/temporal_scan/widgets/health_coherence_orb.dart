import 'dart:math';

import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class HealthCoherenceOrb extends StatefulWidget {
  const HealthCoherenceOrb({super.key});

  @override
  State<HealthCoherenceOrb> createState() => _HealthCoherenceOrbState();
}

class _HealthCoherenceOrbState extends State<HealthCoherenceOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = min(constraints.maxWidth, 300.0);
        final outer = size;
        final inner = size * 0.72;
        final core = size * 0.46;
        return Column(
          children: [
            Text(
              'HEALTH COHERENCE',
              style: AppText.hudLabel.copyWith(
                fontSize: 12,
                letterSpacing: 3,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: size + 40,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size(outer, outer),
                    painter: _RadarRingsPainter(),
                  ),
                  Container(
                    width: outer,
                    height: outer,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.textMuted.withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                  ),
                  Container(
                    width: inner,
                    height: inner,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.textMuted.withOpacity(0.22),
                        width: 1,
                      ),
                    ),
                  ),
                  ScaleTransition(
                    scale: _pulse,
                    child: Container(
                      width: core,
                      height: core,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.neonCyan.withOpacity(0.06),
                        border: Border.all(
                          color: AppColors.neonCyan.withOpacity(0.55),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neonCyan.withOpacity(0.25),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 22,
                    bottom: 44,
                    child: Text(
                      'START',
                      style: AppText.hudLabel.copyWith(
                        fontSize: 10,
                        letterSpacing: 2.4,
                        color: AppColors.textMuted.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 26,
                    top: 30,
                    child: Text(
                      'CURRENT',
                      style: AppText.hudLabel.copyWith(
                        fontSize: 10,
                        letterSpacing: 2.4,
                        color: AppColors.neonCyan,
                      ),
                    ),
                  ),
                  Positioned(
                    left: size * 0.17,
                    child: Container(
                      width: 34,
                      height: 1,
                      color: AppColors.textMuted.withOpacity(0.25),
                    ),
                  ),
                  Positioned(
                    right: size * 0.17,
                    child: Container(
                      width: 34,
                      height: 1,
                      color: AppColors.textMuted.withOpacity(0.25),
                    ),
                  ),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.neonCyan,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonCyan.withOpacity(0.4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RadarRingsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textMuted.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2.2, paint);
    canvas.drawCircle(center, size.width / 2.75, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
