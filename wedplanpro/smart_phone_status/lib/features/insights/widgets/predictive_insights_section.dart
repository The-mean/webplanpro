import 'package:flutter/material.dart';

import 'package:smart_phone_status/features/insights/widgets/insight_card.dart';
import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class PredictiveInsightsSection extends StatelessWidget {
  const PredictiveInsightsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'PREDICTIVE INSIGHTS',
          trailing: const Icon(Icons.analytics_outlined,
              size: 18, color: AppColors.neonCyan),
        ),
        const SizedBox(height: 16),
        const InsightCard(
          title: 'COOLING SYSTEM OPTIMIZED',
          subtitle: 'AUTO-REGULATION ACTIVE // PEAK PERF. MAINTAINED',
          icon: Icons.ac_unit,
          tone: InsightTone.active,
        ),
        const SizedBox(height: 14),
        const InsightCard(
          title: 'BATTERY LONGEVITY PREDICTED',
          subtitle: '+4 MONTHS EXTENSION // DEGRADATION SLOWED',
          icon: Icons.battery_charging_full,
          tone: InsightTone.active,
        ),
        const SizedBox(height: 14),
        const InsightCard(
          title: 'BACKGROUND PROCESSES',
          subtitle: '14 APPS SUSPENDED // RAM CLEARED',
          icon: Icons.memory,
          tone: InsightTone.neutral,
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppText.hudLabel.copyWith(
            fontSize: 13,
            letterSpacing: 3,
            color: AppColors.neonCyan,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.cardBorder,
          ),
        ),
        const SizedBox(width: 12),
        if (trailing != null) trailing!,
      ],
    );
  }
}
