import 'package:flutter/material.dart';

import 'package:smart_phone_status/features/onboarding/widgets/page_indicator.dart';
import 'package:smart_phone_status/features/onboarding/widgets/primary_action_button.dart';
import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.header,
    required this.hero,
    required this.titleTop,
    required this.titleAccent,
    required this.subtitle,
    required this.indicatorIndex,
    required this.buttonLabel,
    required this.filledButton,
    required this.onAction,
    this.accentColor = AppColors.neonCyan,
  });

  final Widget header;
  final Widget hero;
  final String titleTop;
  final String titleAccent;
  final String subtitle;
  final int indicatorIndex;
  final String buttonLabel;
  final bool filledButton;
  final VoidCallback onAction;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          header,
          const SizedBox(height: 18),
          hero,
          const SizedBox(height: 26),
          Column(
            children: [
              Text(
                titleTop,
                textAlign: TextAlign.center,
                style: AppText.title.copyWith(
                  fontSize: 28,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                titleAccent,
                textAlign: TextAlign.center,
                style: AppText.title.copyWith(
                  fontSize: 30,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                  color: accentColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppText.bodyMuted.copyWith(
                fontSize: 14,
                height: 1.6,
                color: AppColors.textMuted.withOpacity(0.8),
              ),
            ),
          ),
          const Spacer(),
          PageIndicator(
            count: 3,
            index: indicatorIndex,
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: PrimaryActionButton(
              label: buttonLabel,
              filled: filledButton,
              onPressed: onAction,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
