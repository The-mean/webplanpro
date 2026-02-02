import 'package:flutter/material.dart';

import 'package:smart_phone_status/features/onboarding/widgets/hardware_vitality_card.dart';
import 'package:smart_phone_status/features/onboarding/widgets/onboarding_page.dart';
import 'package:smart_phone_status/features/onboarding/widgets/orb_visualization.dart';
import 'package:smart_phone_status/features/onboarding/widgets/subtle_onboarding_background.dart';
import 'package:smart_phone_status/features/onboarding/widgets/trend_chart_card.dart';
import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSkip() {
    // TODO: onFinish navigation eklenecek.
    // TODO: onboarding skip analytics eventi eklenecek.
  }

  void _onNext() {
    if (_index < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    } else {
      _onFinish();
    }
  }

  void _onFinish() {
    // TODO: onFinish navigation eklenecek.
    // TODO: onboarding complete analytics eventi eklenecek.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1D20),
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(child: SubtleOnboardingBackground()),
            Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (value) {
                      setState(() => _index = value);
                      // TODO: onboarding page view analytics eventi eklenecek.
                    },
                    children: [
                      OnboardingPage(
                        header: _SysDiagHeader(onSkip: _onSkip),
                        hero: const OrbVisualization(),
                        titleTop: 'YOUR PHONE',
                        titleAccent: 'AGES DAILY',
                        subtitle:
                            'Track your device’s vital health\nsignals in real-time.',
                        indicatorIndex: _index,
                        buttonLabel: 'CONTINUE',
                        filledButton: false,
                        onAction: _onNext,
                      ),
                      OnboardingPage(
                        header: _SkipHeader(
                          label: 'SKIP >',
                          onSkip: _onSkip,
                        ),
                        hero: const HardwareVitalityCard(),
                        titleTop: 'SEE REAL',
                        titleAccent: 'PERFORMANCE AGE',
                        subtitle:
                            'Go beyond the physical years.\nAnalyze your device’s true\ncapability.',
                        indicatorIndex: _index,
                        buttonLabel: 'CONTINUE',
                        filledButton: true,
                        onAction: _onNext,
                      ),
                      OnboardingPage(
                        header: _SkipHeader(
                          label: 'SKIP',
                          onSkip: _onSkip,
                        ),
                        hero: const TrendChartCard(),
                        titleTop: 'PREDICT ISSUES',
                        titleAccent: 'EARLY',
                        accentColor: AppColors.textPrimary,
                        subtitle: 'Prevention through system intelligence.',
                        indicatorIndex: _index,
                        buttonLabel: 'GET STARTED',
                        filledButton: true,
                        onAction: _onFinish,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SysDiagHeader extends StatelessWidget {
  const _SysDiagHeader({required this.onSkip});

  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: 10,
      ),
      child: Row(
        children: [
          Row(
            children: [
              const Icon(Icons.query_stats,
                  size: 20, color: AppColors.neonCyan),
              const SizedBox(width: 8),
              Text(
                'SYS.DIAG',
                style: AppText.hudLabel.copyWith(
                  fontSize: 12,
                  letterSpacing: 2.4,
                  color: AppColors.neonCyan.withOpacity(0.8),
                ),
              ),
            ],
          ),
          const Spacer(),
          InkResponse(
            onTap: onSkip,
            radius: 20,
            child: Text(
              'SKIP',
              style: AppText.hudLabel.copyWith(
                fontSize: 12,
                letterSpacing: 2.4,
                color: AppColors.textMuted.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkipHeader extends StatelessWidget {
  const _SkipHeader({required this.label, required this.onSkip});

  final String label;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: 12,
      ),
      child: Row(
        children: [
          const Spacer(),
          InkResponse(
            onTap: onSkip,
            radius: 20,
            child: Text(
              label,
              style: AppText.hudLabel.copyWith(
                fontSize: 12,
                letterSpacing: 2.4,
                color: AppColors.textMuted.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
