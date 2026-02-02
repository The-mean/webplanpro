import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key, required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: isActive ? 44 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.neonCyan
                : AppColors.textMuted.withOpacity(0.4),
            borderRadius: BorderRadius.circular(999),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.neonCyan.withOpacity(0.3),
                      blurRadius: 10,
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}
