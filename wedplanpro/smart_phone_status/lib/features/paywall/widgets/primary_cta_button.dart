import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class PrimaryCtaButton extends StatelessWidget {
  const PrimaryCtaButton({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppSpacing.radius),
      child: Container(
        height: 54,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.neonCyan.withOpacity(0.95),
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonCyan.withOpacity(0.25),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, color: Colors.black),
            const SizedBox(width: 12),
            Text(
              label,
              style: AppText.title.copyWith(
                fontSize: 16,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
