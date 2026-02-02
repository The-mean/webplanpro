import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/models/pro_insights.dart';
import '../../../l10n/app_localizations.dart';

class DigitalDnaCard extends StatelessWidget {
  const DigitalDnaCard({super.key, required this.dna});

  final DigitalDna dna;

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
          Text(loc.digitalDna, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          _Row(
            label: loc.profile,
            value: _profileLabel(loc),
          ),
          const SizedBox(height: 8),
          _Row(
            label: loc.riskArea,
            value: _riskLabel(loc),
          ),
          const SizedBox(height: 8),
          _Row(
            label: loc.strength,
            value: _strengthLabel(loc),
          ),
        ],
      ),
    );
  }

  String _profileLabel(AppLocalizations loc) {
    switch (dna.profileKey) {
      case 'profileLight':
        return loc.profileLight;
      case 'profileHeavy':
        return loc.profileHeavy;
      default:
        return loc.profileBalanced;
    }
  }

  String _riskLabel(AppLocalizations loc) {
    switch (dna.riskKey) {
      case 'riskBattery':
        return loc.riskBattery;
      case 'riskHeat':
        return loc.riskHeat;
      default:
        return loc.riskStorage;
    }
  }

  String _strengthLabel(AppLocalizations loc) {
    switch (dna.strengthKey) {
      case 'strengthPerformance':
        return loc.strengthPerformance;
      default:
        return loc.strengthStability;
    }
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(value, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
