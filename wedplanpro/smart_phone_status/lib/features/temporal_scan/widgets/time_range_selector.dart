import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class TimeRangeSelector extends StatelessWidget {
  const TimeRangeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    const selected = 0;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.cardBorder.withOpacity(0.6),
          width: 0.8,
        ),
      ),
      child: Row(
        children: [
          _Segment(
            label: '7D',
            isSelected: selected == 0,
          ),
          _Segment(
            label: '30D',
            isSelected: selected == 1,
          ),
          _Segment(
            label: '90D',
            isSelected: selected == 2,
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({required this.label, required this.isSelected});

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final textColor =
        isSelected ? AppColors.neonCyan : AppColors.textMuted.withOpacity(0.7);
    return Expanded(
      child: Container(
        height: 44,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.neonCyan.withOpacity(0.12) : null,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(
                  color: AppColors.neonCyan.withOpacity(0.5),
                  width: 1,
                )
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.neonCyan.withOpacity(0.2),
                    blurRadius: 6,
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: AppText.hudLabel.copyWith(
            fontSize: 12,
            letterSpacing: 2.4,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
