import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class HardwareVitalityCard extends StatelessWidget {
  const HardwareVitalityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: Row(
            children: [
              Text(
                'SYSTEM ANALYSIS // v.2.0.4',
                style: AppText.hudLabel.copyWith(
                  fontSize: 11,
                  letterSpacing: 2.2,
                  color: AppColors.neonCyan.withOpacity(0.7),
                ),
              ),
              const Spacer(),
              const Icon(Icons.fingerprint,
                  size: 18, color: AppColors.neonCyan),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppSpacing.radius),
            border: Border.all(
              color: AppColors.neonCyan.withOpacity(0.4),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.neonCyan.withOpacity(0.12),
                blurRadius: 12,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'HARDWARE AGE',
                    style: AppText.hudLabel.copyWith(
                      fontSize: 11.5,
                      letterSpacing: 2.4,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '2.4',
                    style: AppText.title.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'YRS',
                    style: AppText.hudLabel.copyWith(
                      fontSize: 11,
                      letterSpacing: 2,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _ThinBar(
                value: 0.72,
                color: AppColors.textMuted.withOpacity(0.55),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'PHYSICAL DEGRADATION DETECTED',
                  style: AppText.hudLabel.copyWith(
                    fontSize: 10,
                    letterSpacing: 2,
                    color: AppColors.textMuted.withOpacity(0.6),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Text(
                    'SOFTWARE VITALITY',
                    style: AppText.hudLabel.copyWith(
                      fontSize: 11.5,
                      letterSpacing: 2.4,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '98%',
                    style: AppText.title.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.neonCyan,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'VIT',
                    style: AppText.hudLabel.copyWith(
                      fontSize: 11,
                      letterSpacing: 2,
                      color: AppColors.neonCyan,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _StripedBar(value: 0.92),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'PERFORMANCE OPTIMIZED',
                  style: AppText.hudLabel.copyWith(
                    fontSize: 10,
                    letterSpacing: 2,
                    color: AppColors.neonCyan.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ThinBar extends StatelessWidget {
  const _ThinBar({required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.textMuted.withOpacity(0.15),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: constraints.maxWidth * value,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StripedBar extends StatelessWidget {
  const _StripedBar({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: AppColors.textMuted.withOpacity(0.15),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(
              height: 12,
              width: constraints.maxWidth * value,
              child: CustomPaint(
                painter: _StripePainter(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()
      ..color = AppColors.neonCyan.withOpacity(0.9)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(4),
      ),
      background,
    );
    final stripePaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..strokeWidth = 2;
    for (double x = -size.height; x < size.width; x += 10) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height, size.height),
        stripePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
