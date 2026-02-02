import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_shadows.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

enum InsightTone { active, neutral }

class InsightCard extends StatelessWidget {
  const InsightCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.tone = InsightTone.active,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final InsightTone tone;

  @override
  Widget build(BuildContext context) {
    final isActive = tone == InsightTone.active;
    final accent = isActive ? AppColors.neonCyan : AppColors.textMuted;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: AppShadows.softCard,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: accent.withOpacity(0.4),
                        blurRadius: 6,
                      ),
                    ]
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppText.title.copyWith(
                    fontSize: 15,
                    letterSpacing: 1.2,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: AppText.bodyMuted.copyWith(
                    fontSize: 12,
                    letterSpacing: 1.4,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: accent, size: 20),
        ],
      ),
    );
  }
}
