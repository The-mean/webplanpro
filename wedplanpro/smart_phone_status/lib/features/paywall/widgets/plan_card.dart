import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.isSelected,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.period,
    this.badge,
  });

  final bool isSelected;
  final String title;
  final String subtitle;
  final String price;
  final String period;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? AppColors.neonCyan.withOpacity(0.7)
        : AppColors.cardBorder.withOpacity(0.45);
    return Stack(
      children: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(AppSpacing.radius),
              border: Border.all(color: borderColor, width: 0.8),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.neonCyan.withOpacity(0.18),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: Row(
              children: [
                _Selector(isSelected: isSelected),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppText.title.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: AppText.title.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      period,
                      style: AppText.hudLabel.copyWith(
                        fontSize: 11,
                        letterSpacing: 2.1,
                        color: AppColors.neonCyan.withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (badge != null)
          Positioned(
            top: -8,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.neonCyan,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neonCyan.withOpacity(0.25),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Text(
                badge!,
                style: AppText.hudLabel.copyWith(
                  fontSize: 10,
                  letterSpacing: 1.8,
                  color: Colors.black,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _Selector extends StatelessWidget {
  const _Selector({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.neonCyan.withOpacity(0.15),
          border: Border.all(
            color: AppColors.neonCyan.withOpacity(0.85),
            width: 1,
          ),
        ),
        child: Icon(
          Icons.check,
          size: 14,
          color: AppColors.neonCyan.withOpacity(0.95),
        ),
      );
    }
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.textMuted.withOpacity(0.5),
          width: 0.9,
        ),
      ),
    );
  }
}
