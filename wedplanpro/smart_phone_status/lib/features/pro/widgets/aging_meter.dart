import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/models/pro_insights.dart';
import '../../../l10n/app_localizations.dart';

class AgingMeter extends StatelessWidget {
  const AgingMeter({super.key, required this.metrics});

  final AgingMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(AppDimens.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radius),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(loc.phoneAgingMeter, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          _AgeRow(
            label: loc.deviceAge,
            value: _formatYears(metrics.deviceAgeYears, loc.yearsShort),
          ),
          const SizedBox(height: 8),
          _AgeRow(
            label: loc.performanceAge,
            value: _formatYears(metrics.performanceAgeYears, loc.yearsShort),
          ),
          const SizedBox(height: 12),
          Text(
            '${loc.agingSpeed}: ${_speedLabel(loc, metrics.speed)}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  String _formatYears(double years, String unit) {
    final value = years.toStringAsFixed(1);
    return '$value$unit';
  }

  String _speedLabel(AppLocalizations loc, AgingSpeed speed) {
    switch (speed) {
      case AgingSpeed.fast:
        return loc.speedFast;
      case AgingSpeed.slow:
        return loc.speedSlow;
      case AgingSpeed.normal:
      default:
        return loc.speedNormal;
    }
  }
}

class _AgeRow extends StatelessWidget {
  const _AgeRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(value, style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
