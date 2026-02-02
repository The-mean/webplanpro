import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class LockedModuleCard extends StatelessWidget {
  const LockedModuleCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 98,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        border: Border.all(
          color: AppColors.cardBorder.withOpacity(0.6),
          width: 0.8,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _GhostBar(),
                  _GhostBar(),
                  _GhostBar(),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock, color: AppColors.neonCyan, size: 22),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: AppText.title.copyWith(
                    fontSize: 15.5,
                    letterSpacing: 1.8,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: AppText.hudLabel.copyWith(
                    fontSize: 10.5,
                    letterSpacing: 2.1,
                    color: AppColors.neonCyan.withOpacity(0.65),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GhostBar extends StatelessWidget {
  const _GhostBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.neonCyan.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
