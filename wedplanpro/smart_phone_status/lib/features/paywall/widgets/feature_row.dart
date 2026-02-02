import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class FeatureRow extends StatelessWidget {
  const FeatureRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.neonCyan.withOpacity(0.28),
              width: 0.7,
            ),
            color: Colors.white.withOpacity(0.02),
          ),
          child: Icon(
            icon,
            color: AppColors.neonCyan.withOpacity(0.9),
            size: 20,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppText.hudLabel.copyWith(
                  fontSize: 12,
                  letterSpacing: 2.4,
                  fontWeight: FontWeight.w600,
                  color: AppColors.neonCyan.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: AppText.bodyMuted.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textMuted.withOpacity(0.75),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
