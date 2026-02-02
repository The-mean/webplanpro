import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class ProtocolPlanCard extends StatelessWidget {
  const ProtocolPlanCard({
    super.key,
    required this.title,
    required this.price,
    required this.period,
    required this.isSelected,
    this.subtitle,
  });

  final String title;
  final String price;
  final String period;
  final String? subtitle;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? AppColors.neonCyan.withOpacity(0.7)
        : AppColors.cardBorder.withOpacity(0.4);
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppSpacing.radius),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          border: Border.all(color: borderColor, width: 0.8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.neonCyan.withOpacity(0.16),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            _SelectionSquare(isSelected: isSelected),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppText.title.copyWith(
                      fontSize: 15.5,
                      letterSpacing: 1.9,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      subtitle!,
                      style: AppText.hudLabel.copyWith(
                        fontSize: 10.5,
                        letterSpacing: 1.9,
                        color: AppColors.neonCyan.withOpacity(0.65),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: AppText.title.copyWith(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  period,
                  style: AppText.hudLabel.copyWith(
                    fontSize: 10.5,
                    letterSpacing: 2.1,
                    color: AppColors.textMuted.withOpacity(0.65),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectionSquare extends StatelessWidget {
  const _SelectionSquare({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.neonCyan.withOpacity(0.16) : null,
        border: Border.all(
          color: isSelected
              ? AppColors.neonCyan.withOpacity(0.85)
              : AppColors.textMuted.withOpacity(0.35),
          width: 0.9,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.neonCyan,
                  shape: BoxShape.rectangle,
                ),
              ),
            )
          : null,
    );
  }
}
