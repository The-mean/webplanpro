import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/models/time_capsule.dart';
import '../../../l10n/app_localizations.dart';

class TimeCapsuleCard extends StatelessWidget {
  const TimeCapsuleCard({super.key, required this.items});

  final List<TimeCapsuleItem> items;

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
          Text(loc.timeCapsule, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          for (final item in items) ...[
            _CapsuleRow(item: item),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _CapsuleRow extends StatelessWidget {
  const _CapsuleRow({required this.item});

  final TimeCapsuleItem item;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final label = _label(loc, item.days);
    final value = item.deltaScore == null
        ? loc.noData
        : '${item.deltaScore! >= 0 ? '+' : ''}${item.deltaScore}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(value, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }

  String _label(AppLocalizations loc, int days) {
    switch (days) {
      case 7:
        return loc.compare7;
      case 30:
        return loc.compare30;
      case 90:
        return loc.compare90;
      default:
        return '${days}d';
    }
  }
}
