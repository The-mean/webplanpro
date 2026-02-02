import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_shadows.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class DigitalDnaSection extends StatelessWidget {
  const DigitalDnaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'DIGITAL DNA PROFILE',
          trailing: const Icon(Icons.fingerprint,
              size: 18, color: AppColors.neonCyan),
        ),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(
              child: HudModuleCard(
                icon: Icons.view_in_ar_outlined,
                title: 'ARCHETYPE',
                value: 'POWER',
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: HudModuleCard(
                icon: Icons.thermostat,
                title: 'RISK AREA',
                value: 'THERMAL',
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: HudModuleCard(
                icon: Icons.bolt,
                title: 'STRENGTH',
                value: 'STABLE',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HudModuleCard extends StatelessWidget {
  const HudModuleCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(AppSpacing.radius),
              border: Border.all(color: AppColors.cardBorder),
              boxShadow: AppShadows.softCard,
            ),
          ),
          const _CornerAccents(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: AppColors.neonCyan, size: 26),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: AppText.hudLabel.copyWith(
                    fontSize: 11,
                    letterSpacing: 2.2,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: AppText.title.copyWith(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
      ..color = AppColors.neonCyan.withOpacity(0.35)
      ..strokeWidth = 1;
    const length = 10.0;

    // Top-left
    canvas.drawLine(const Offset(0, 0), const Offset(length, 0), paint);
    canvas.drawLine(const Offset(0, 0), const Offset(0, length), paint);

    // Top-right
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width - length, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width, length),
      paint,
    );

    // Bottom-left
    canvas.drawLine(
      Offset(0, size.height),
      Offset(length, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height),
      Offset(0, size.height - length),
      paint,
    );

    // Bottom-right
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - length, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - length),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppText.hudLabel.copyWith(
            fontSize: 13,
            letterSpacing: 3,
            color: AppColors.neonCyan,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.cardBorder,
          ),
        ),
        const SizedBox(width: 12),
        if (trailing != null) trailing!,
      ],
    );
  }
}
