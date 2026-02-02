import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const _HudIcon(icon: Icons.menu),
          Expanded(
            child: Center(
              child: Text(
                'SMART STATUS v2.0',
                style: AppText.hudLabel.copyWith(
                  fontSize: 14,
                  letterSpacing: 4,
                  color: AppColors.neonCyan,
                ),
              ),
            ),
          ),
          const _HudIcon(icon: Icons.settings),
        ],
      ),
    );
  }
}

class _HudIcon extends StatelessWidget {
  const _HudIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: Icon(
          icon,
          color: AppColors.textMuted,
          size: 22,
        ),
      ),
    );
  }
}
