import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class AgingVectorSection extends StatelessWidget {
  const AgingVectorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.show_chart,
                    size: 16, color: AppColors.textMuted),
                const SizedBox(width: 8),
                Text(
                  'AGING VECTOR',
                  style: AppText.hudLabel.copyWith(
                    fontSize: 11.5,
                    letterSpacing: 2.6,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'STABLE',
              style: AppText.title.copyWith(
                fontSize: 28,
                letterSpacing: 1.4,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '+2.4%',
              style: AppText.title.copyWith(
                fontSize: 18,
                color: AppColors.neonCyan,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'EFFICIENCY',
              style: AppText.hudLabel.copyWith(
                fontSize: 10.5,
                letterSpacing: 2.2,
                color: AppColors.textMuted.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
