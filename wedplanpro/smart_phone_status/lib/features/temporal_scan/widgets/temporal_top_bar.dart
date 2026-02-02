import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class TemporalTopBar extends StatelessWidget {
  const TemporalTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
            color: AppColors.textMuted,
            splashRadius: 18,
          ),
          Expanded(
            child: Center(
              child: Text(
                'TEMPORAL SCAN',
                style: AppText.hudLabel.copyWith(
                  fontSize: 14,
                  letterSpacing: 3.6,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            color: AppColors.textMuted,
            splashRadius: 18,
          ),
        ],
      ),
    );
  }
}
