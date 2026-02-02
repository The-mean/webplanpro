import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class SystemStatusFooter extends StatelessWidget {
  const SystemStatusFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'SYSTEM STABILITY TRENDING UPWARD',
            style: AppText.hudLabel.copyWith(
              fontSize: 11.5,
              letterSpacing: 2.6,
              color: AppColors.neonCyan.withOpacity(0.6),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radius),
            border: Border.all(
              color: AppColors.neonCyan.withOpacity(0.4),
              width: 1,
            ),
            color: AppColors.neonCyan.withOpacity(0.08),
          ),
          child: Text(
            'OPTIMAL',
            style: AppText.hudLabel.copyWith(
              fontSize: 10.5,
              letterSpacing: 2.4,
              color: AppColors.neonCyan,
            ),
          ),
        ),
      ],
    );
  }
}
