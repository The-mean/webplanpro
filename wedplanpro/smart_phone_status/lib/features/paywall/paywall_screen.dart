import 'package:flutter/material.dart';

import 'package:smart_phone_status/features/paywall/widgets/feature_row.dart';
import 'package:smart_phone_status/features/paywall/widgets/footer_links.dart';
import 'package:smart_phone_status/features/paywall/widgets/plan_card.dart';
import 'package:smart_phone_status/features/paywall/widgets/primary_cta_button.dart';
import 'package:smart_phone_status/features/paywall/widgets/subtle_paywall_background.dart';
import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: in_app_purchase baglantisi ve secim durumu eklenecek.
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(child: SubtlePaywallBackground()),
            Column(
              children: [
                const _PaywallHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding,
                    ),
                    child: Column(
                      children: const [
                        SizedBox(height: 6),
                        _OrbIcon(),
                        SizedBox(height: 22),
                        FeatureRow(
                          icon: Icons.hourglass_bottom,
                          title: 'PHONE AGING METER',
                          subtitle: 'Real-time degradation analysis',
                        ),
                        _DottedDivider(),
                        FeatureRow(
                          icon: Icons.fingerprint,
                          title: 'DIGITAL DNA PROFILE',
                          subtitle: 'Deep hardware specification scan',
                        ),
                        _DottedDivider(),
                        FeatureRow(
                          icon: Icons.warning_amber,
                          title: 'PREDICTIVE WARNINGS',
                          subtitle: 'AI-driven failure alerts',
                        ),
                        _DottedDivider(),
                        FeatureRow(
                          icon: Icons.timeline,
                          title: 'TIME CAPSULE TRENDS',
                          subtitle: 'Historical performance data',
                        ),
                        SizedBox(height: 26),
                        PlanCard(
                          isSelected: true,
                          badge: 'BEST VALUE',
                          title: 'Yearly Access',
                          subtitle: 'Save 50% vs Monthly',
                          price: '\$29.99',
                          period: '/ YEAR',
                        ),
                        SizedBox(height: 14),
                        PlanCard(
                          isSelected: false,
                          title: 'Monthly Access',
                          subtitle: 'Flexible billing',
                          price: '\$4.99',
                          period: '/ MONTH',
                        ),
                        SizedBox(height: 20),
                        PrimaryCtaButton(label: 'UNLOCK PRO'),
                        SizedBox(height: 18),
                        FooterLinks(),
                        SizedBox(height: 12),
                        _DisclaimerText(),
                        SizedBox(height: 24),
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

class _PaywallHeader extends StatelessWidget {
  const _PaywallHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          const SizedBox(width: 40),
          Expanded(
            child: Center(
              child: Text(
                'UNLOCK PRO INTELLIGENCE',
                style: AppText.hudLabel.copyWith(
                  fontSize: 13,
                  letterSpacing: 3.2,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          InkResponse(
            onTap: () {},
            radius: 18,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: AppColors.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrbIcon extends StatelessWidget {
  const _OrbIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.neonCyan.withOpacity(0.35),
          width: 1,
        ),
      ),
      child: Center(
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.neonCyan.withOpacity(0.08),
            boxShadow: [
              BoxShadow(
                color: AppColors.neonCyan.withOpacity(0.25),
                blurRadius: 10,
              ),
            ],
          ),
          child: const Icon(Icons.verified, color: AppColors.neonCyan),
        ),
      ),
    );
  }
}

class _DottedDivider extends StatelessWidget {
  const _DottedDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: CustomPaint(
        painter: _DottedDividerPainter(),
        child: const SizedBox(height: 1, width: double.infinity),
      ),
    );
  }
}

class _DottedDividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.cardBorder.withOpacity(0.7)
      ..strokeWidth = 1;
    const dashWidth = 4.0;
    const dashSpace = 4.0;
    var startX = 0.0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DisclaimerText extends StatelessWidget {
  const _DisclaimerText();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Subscription automatically renews unless auto-renew is turned off '
      'at least 24-hours before the end of the current period.',
      textAlign: TextAlign.center,
      style: AppText.bodyMuted.copyWith(
        fontSize: 11,
        height: 1.4,
        color: AppColors.textMuted.withOpacity(0.7),
      ),
    );
  }
}
