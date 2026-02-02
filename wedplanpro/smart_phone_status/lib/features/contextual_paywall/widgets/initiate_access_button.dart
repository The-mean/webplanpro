import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class InitiateAccessButton extends StatelessWidget {
  const InitiateAccessButton({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: MainPaywallScreen'e yonlendirilecek.
      },
      borderRadius: BorderRadius.circular(AppSpacing.radius),
      child: CustomPaint(
        painter: _CornerBracketPainter(),
        child: Container(
          height: 54,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radius),
            border: Border.all(
              color: AppColors.neonCyan.withOpacity(0.6),
              width: 0.9,
            ),
            color: Colors.white.withOpacity(0.02),
            boxShadow: [
              BoxShadow(
                color: AppColors.neonCyan.withOpacity(0.14),
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fingerprint, color: AppColors.neonCyan),
              const SizedBox(width: 12),
              Text(
                label,
                style: AppText.hudLabel.copyWith(
                  fontSize: 13,
                  letterSpacing: 3.6,
                  fontWeight: FontWeight.w700,
                  color: AppColors.neonCyan,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CornerBracketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.neonCyan.withOpacity(0.5)
      ..strokeWidth = 1;
    const corner = 9.0;

    canvas.drawLine(
        const Offset(0, 0), const Offset(corner, 0), paint);
    canvas.drawLine(
        const Offset(0, 0), const Offset(0, corner), paint);

    canvas.drawLine(Offset(size.width, 0),
        Offset(size.width - corner, 0), paint);
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width, corner), paint);

    canvas.drawLine(Offset(0, size.height),
        Offset(corner, size.height), paint);
    canvas.drawLine(Offset(0, size.height),
        Offset(0, size.height - corner), paint);

    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width - corner, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width, size.height - corner), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
