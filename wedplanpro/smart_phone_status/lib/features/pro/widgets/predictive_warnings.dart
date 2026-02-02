import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/models/predictive_warning.dart';
import '../../../l10n/app_localizations.dart';

class PredictiveWarningsCard extends StatelessWidget {
  const PredictiveWarningsCard({super.key, required this.warnings});

  final List<PredictiveWarning> warnings;

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
          Text(loc.predictiveWarnings,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          if (warnings.isEmpty)
            Text(loc.noWarnings, style: Theme.of(context).textTheme.bodyMedium)
          else
            for (final warning in warnings) ...[
              _WarningRow(warning: warning),
              const SizedBox(height: 8),
            ],
        ],
      ),
    );
  }
}

class _WarningRow extends StatelessWidget {
  const _WarningRow({required this.warning});

  final PredictiveWarning warning;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.warning_amber, color: AppColors.warn),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_title(loc, warning.titleKey),
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 2),
              Text(_detail(loc, warning.detailKey),
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  String _title(AppLocalizations loc, String key) {
    switch (key) {
      case 'warnHeatTitle':
        return loc.warnHeatTitle;
      case 'warnStorageTitle':
        return loc.warnStorageTitle;
      case 'warnBatteryTitle':
        return loc.warnBatteryTitle;
      default:
        return loc.warnGenericTitle;
    }
  }

  String _detail(AppLocalizations loc, String key) {
    switch (key) {
      case 'warnHeatDetail':
        return loc.warnHeatDetail;
      case 'warnStorageDetail':
        return loc.warnStorageDetail;
      case 'warnBatteryDetail':
        return loc.warnBatteryDetail;
      default:
        return loc.warnGenericDetail;
    }
  }
}
