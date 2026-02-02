import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../core/constants.dart';
import '../../core/providers.dart';
import '../../l10n/app_localizations.dart';

class ProScreen extends ConsumerWidget {
  const ProScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final service = ref.watch(subscriptionServiceProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.upgrade),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProHeader(isPro: service.isPro),
            const SizedBox(height: 16),
            _FeatureRow(label: loc.proFeatureAging),
            _FeatureRow(label: loc.proFeatureDna),
            _FeatureRow(label: loc.proFeatureWarnings),
            _FeatureRow(label: loc.proFeatureTimeCapsule),
            const SizedBox(height: 24),
            Text(loc.choosePlan, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            FutureBuilder<List<ProductDetails>>(
              future: service.fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final products = snapshot.data ?? [];
                if (products.isEmpty) {
                  return Text(loc.storeUnavailable,
                      style: Theme.of(context).textTheme.bodyMedium);
                }
                return Column(
                  children: products.map((product) {
                    final label = _productLabel(loc, product.id);
                    return _PlanCard(
                      title: label,
                      price: product.price,
                      onTap: () => service.buy(product),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => service.restorePurchases(),
              child: Text(loc.restorePurchases),
            ),
          ],
        ),
      ),
    );
  }

  String _productLabel(AppLocalizations loc, String id) {
    if (id.contains('year')) return loc.subscribeYearly;
    return loc.subscribeMonthly;
  }
}

class _ProHeader extends StatelessWidget {
  const _ProHeader({required this.isPro});

  final bool isPro;

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
      child: Row(
        children: [
          const Icon(Icons.star, color: AppColors.neonSoft),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isPro ? loc.proActive : loc.proInactive,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check, color: AppColors.good, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(label)),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.price,
    required this.onTap,
  });

  final String title;
  final String price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(AppDimens.cardPadding),
        decoration: BoxDecoration(
          color: AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(AppDimens.radius),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
            FilledButton(
              onPressed: onTap,
              child: Text(price),
            ),
          ],
        ),
      ),
    );
  }
}
