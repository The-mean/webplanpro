import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.filled,
    required this.onPressed,
  });

  final String label;
  final bool filled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textColor = filled ? Colors.black : AppColors.textPrimary;
    final bgColor = filled ? AppColors.neonCyan : Colors.white.withOpacity(0.04);
    final borderColor =
        filled ? Colors.transparent : AppColors.neonCyan.withOpacity(0.7);

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppSpacing.radius),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonCyan.withOpacity(filled ? 0.35 : 0.2),
              blurRadius: filled ? 12 : 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: AppText.title.copyWith(
                fontSize: 16,
                letterSpacing: 3,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.arrow_forward,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
