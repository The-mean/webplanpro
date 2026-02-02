import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_shadows.dart';

class BottomHudNav extends StatelessWidget {
  const BottomHudNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.cardBorder),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _HudNavItem(
            icon: Icons.home_filled,
            isActive: true,
          ),
          _HudNavItem(icon: Icons.show_chart),
          _HudNavItem(icon: Icons.shield_outlined),
        ],
      ),
    );
  }
}

class _HudNavItem extends StatelessWidget {
  const _HudNavItem({required this.icon, this.isActive = false});

  final IconData icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.neonCyan : AppColors.textMuted;
    return SizedBox(
      width: 64,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: isActive ? AppShadows.neonGlow : null,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 4,
            width: isActive ? 6 : 0,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
