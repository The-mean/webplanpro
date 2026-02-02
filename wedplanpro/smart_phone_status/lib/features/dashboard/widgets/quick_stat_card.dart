import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class QuickStatCard extends StatelessWidget {
  const QuickStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.status,
    required this.icon,
    required this.statusColor,
  });

  final String title;
  final String value;
  final String status;
  final IconData icon;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
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
          Icon(icon, color: AppColors.neonSoft),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            status,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: statusColor,
                ),
          ),
        ],
      ),
    );
  }
}
