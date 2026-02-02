import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class StatusText extends StatelessWidget {
  const StatusText({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppText.title.copyWith(
            fontSize: 18,
            letterSpacing: 3,
            color: AppColors.neonCyan,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppText.bodyMuted.copyWith(
            fontSize: 12,
            letterSpacing: 1.4,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
