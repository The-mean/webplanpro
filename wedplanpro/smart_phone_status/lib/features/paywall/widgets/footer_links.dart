import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class FooterLinks extends StatelessWidget {
  const FooterLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppText.hudLabel.copyWith(
      fontSize: 11,
      letterSpacing: 2.2,
      color: AppColors.textMuted.withOpacity(0.8),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('RESTORE', style: style),
        _Dot(style: style),
        Text('TERMS', style: style),
        _Dot(style: style),
        Text('PRIVACY', style: style),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.style});

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text('•', style: style),
    );
  }
}
