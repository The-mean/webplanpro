import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class InsightsFooter extends StatelessWidget {
  const InsightsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppText.hudLabel.copyWith(
      fontSize: 11,
      letterSpacing: 2.8,
      color: AppColors.textMuted.withOpacity(0.8),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('SYS.ID: 9942-AX', style: style),
        Text('SECURE // ENCRYPTED', style: style),
      ],
    );
  }
}
