import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_shadows.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class MetricGrid extends StatelessWidget {
  const MetricGrid({super.key, required this.metrics});

  final List<MetricData> metrics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: metrics.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 1.05,
      ),
      itemBuilder: (context, index) {
        return MetricCard(data: metrics[index]);
      },
    );
  }
}

class MetricCard extends StatelessWidget {
  const MetricCard({super.key, required this.data});

  final MetricData data;

  @override
  Widget build(BuildContext context) {
    final unitColor = data.unit == '%' || data.unit == '°C'
        ? data.accentColor
        : AppColors.textMuted;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: AppShadows.softCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                data.label,
                style: AppText.hudLabel.copyWith(letterSpacing: 2),
              ),
              const Spacer(),
              Icon(data.icon, size: 18, color: AppColors.textMuted),
            ],
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: data.value,
                  style: AppText.title.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextSpan(
                  text: data.unit,
                  style: AppText.bodyMuted.copyWith(
                    fontSize: 16,
                    color: unitColor,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          _ProgressLine(
            value: data.progress,
            color: data.accentColor,
          ),
        ],
      ),
    );
  }
}

class _ProgressLine extends StatelessWidget {
  const _ProgressLine({required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Stack(
          children: [
            Container(
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.textMuted.withOpacity(0.2),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            Container(
              height: 3,
              width: width * value.clamp(0, 1),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class MetricData {
  MetricData({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.progress,
    required this.accentColor,
  });

  final String label;
  final String value;
  final String unit;
  final IconData icon;
  final double progress;
  final Color accentColor;

  factory MetricData.battery({required int level}) {
    return MetricData(
      label: 'BATTERY LVL',
      value: '$level',
      unit: '%',
      icon: Icons.battery_full,
      progress: level / 100,
      accentColor: AppColors.neonCyan,
    );
  }

  factory MetricData.storage({required int totalGb, required int usedPercent}) {
    return MetricData(
      label: 'STORAGE',
      value: '$totalGb',
      unit: 'GB',
      icon: Icons.sd_storage,
      progress: usedPercent / 100,
      accentColor: AppColors.neonCyan,
    );
  }

  factory MetricData.memory({required double usedGb, required int totalGb}) {
    final progress = totalGb == 0 ? 0 : usedGb / totalGb;
    return MetricData(
      label: 'MEMORY',
      value: usedGb.toStringAsFixed(1),
      unit: 'GB',
      icon: Icons.memory,
      progress: progress,
      accentColor: AppColors.neonCyan,
    );
  }

  factory MetricData.cpuTemp({required int celsius}) {
    return MetricData(
      label: 'CPU TEMP',
      value: '$celsius',
      unit: '°C',
      icon: Icons.thermostat,
      progress: (celsius / 60).clamp(0, 1),
      accentColor: const Color(0xFF3BE3B6),
    );
  }
}
