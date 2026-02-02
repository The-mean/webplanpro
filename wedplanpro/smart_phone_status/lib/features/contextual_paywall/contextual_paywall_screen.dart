import 'package:flutter/material.dart';

import 'package:smart_phone_status/features/contextual_paywall/widgets/initiate_access_button.dart';
import 'package:smart_phone_status/features/contextual_paywall/widgets/locked_module_card.dart';
import 'package:smart_phone_status/features/contextual_paywall/widgets/protocol_plan_card.dart';
import 'package:smart_phone_status/features/contextual_paywall/widgets/subtle_contextual_background.dart';
import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class ContextualPaywallScreen extends StatelessWidget {
  const ContextualPaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Gercek plan durumu ve yonlendirmeler baglanacak.
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(child: SubtleContextualBackground()),
            Column(
              children: [
                const _TopHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 14),
                        _LockedModulesSection(),
                        SizedBox(height: 26),
                        _ProtocolSection(),
                        SizedBox(height: 18),
                        InitiateAccessButton(label: 'INITIATE ACCESS'),
                        SizedBox(height: 18),
                        _FooterLinks(),
                        SizedBox(height: 10),
                        _DisclaimerLine(),
                        SizedBox(height: 22),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.neonCyan.withOpacity(0.8),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'SYSTEM_AUTH_REQ // v.9.0',
                style: AppText.hudLabel.copyWith(
                  fontSize: 11,
                  letterSpacing: 2.4,
                  color: AppColors.neonCyan.withOpacity(0.65),
                ),
              ),
              const Spacer(),
              InkResponse(
                onTap: () {
                  // TODO: onClose eklenecek.
                },
                radius: 20,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.cardBorder.withOpacity(0.6),
                      width: 0.8,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.close, color: AppColors.textMuted),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'AUTHORIZE ADVANCED\nTEMPORAL INTELLIGENCE',
            style: AppText.title.copyWith(
              fontSize: 21,
              height: 1.2,
              letterSpacing: 1.3,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _LockedModulesSection extends StatelessWidget {
  const _LockedModulesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.lock, size: 16, color: AppColors.neonCyan),
            const SizedBox(width: 10),
            Text(
              'LOCKED MODULES',
              style: AppText.hudLabel.copyWith(
                fontSize: 11.5,
                letterSpacing: 2.4,
                color: AppColors.neonCyan.withOpacity(0.9),
              ),
            ),
            const Spacer(),
            Text(
              '2 BLOCKS DETECTED',
              style: AppText.hudLabel.copyWith(
                fontSize: 10.5,
                letterSpacing: 2.2,
                color: AppColors.textMuted.withOpacity(0.6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const LockedModuleCard(
          title: 'INSIGHTS ANALYTICS',
          subtitle: '[ACCESS DENIED]',
        ),
        const SizedBox(height: 14),
        const LockedModuleCard(
          title: 'TIME CAPSULE',
          subtitle: '[ENCRYPTED DATA]',
        ),
      ],
    );
  }
}

class _ProtocolSection extends StatelessWidget {
  const _ProtocolSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _ProtocolHeader(),
        SizedBox(height: 12),
        ProtocolPlanCard(
          title: 'YEARLY',
          subtitle: 'BEST VALUE // SAVE 50%',
          price: '\$29.99',
          period: '/YR',
          isSelected: true,
        ),
        SizedBox(height: 12),
        ProtocolPlanCard(
          title: 'MONTHLY',
          price: '\$4.99',
          period: '/MO',
          isSelected: false,
        ),
      ],
    );
  }
}

class _ProtocolHeader extends StatelessWidget {
  const _ProtocolHeader();

  @override
  Widget build(BuildContext context) {
    return Text(
      'SELECT PROTOCOL',
      style: AppText.hudLabel.copyWith(
        fontSize: 11.5,
        letterSpacing: 2.4,
        color: AppColors.neonCyan.withOpacity(0.7),
      ),
    );
  }
}

class _FooterLinks extends StatelessWidget {
  const _FooterLinks();

  @override
  Widget build(BuildContext context) {
    final style = AppText.hudLabel.copyWith(
      fontSize: 10.5,
      letterSpacing: 2.2,
      color: AppColors.textMuted.withOpacity(0.6),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('RESTORE', style: style),
        const SizedBox(width: 14),
        Text('TERMS', style: style),
        const SizedBox(width: 14),
        Text('PRIVACY', style: style),
      ],
    );
  }
}

class _DisclaimerLine extends StatelessWidget {
  const _DisclaimerLine();

  @override
  Widget build(BuildContext context) {
    return Text(
      'SYS_ADMIN_MSG: AUTO-RENEWAL ACTIVE. CANCEL VIA SETTINGS > 24H '
      'PRE-EXPIRY.',
      textAlign: TextAlign.center,
      style: AppText.bodyMuted.copyWith(
        fontSize: 10,
        height: 1.4,
        letterSpacing: 1.4,
        color: AppColors.textMuted.withOpacity(0.6),
      ),
    );
  }
}
