import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../core/models/time_capsule.dart';
import '../../l10n/app_localizations.dart';
import '../pro/widgets/aging_meter.dart';
import '../pro/widgets/digital_dna.dart';
import '../pro/widgets/predictive_warnings.dart';
import '../pro/widgets/time_capsule.dart';
import 'dashboard_controller.dart';
import 'widgets/quick_stat_card.dart';
import 'widgets/section_header.dart';
import 'widgets/sparkline.dart';
import 'widgets/status_orb.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final state = ref.watch(dashboardControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorState(
          message: loc.genericError,
          onRetry: () => ref
              .read(dashboardControllerProvider.notifier)
              .refresh(),
        ),
        data: (data) {
          final stats = data.stats;
          final orbColor = _orbColor(stats.healthScore);
          final batteryStatus = _statusLabel(
            context,
            score: stats.batteryLevel,
            warnAt: 35,
            badAt: 20,
            higherIsBetter: true,
          );
          final storagePercent = stats.storageUsedPercent;
          final storageStatus = _statusLabel(
            context,
            score: storagePercent.toInt(),
            warnAt: 75,
            badAt: 85,
            higherIsBetter: false,
          );
          final memoryPercent = stats.memoryUsedPercent;
          final memoryStatus = _statusLabel(
            context,
            score: memoryPercent.toInt(),
            warnAt: 75,
            badAt: 85,
            higherIsBetter: false,
          );
          final tempStatus = stats.temperatureC == null
              ? _StatusLabel(text: loc.unknown, color: AppColors.textSecondary)
              : _statusLabel(
                  context,
                  score: stats.temperatureC!.toInt(),
                  warnAt: 37,
                  badAt: 41,
                  higherIsBetter: false,
                );

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(dashboardControllerProvider.notifier).refresh(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppDimens.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StatusOrb(
                        color: orbColor,
                        label: loc.liveStatus,
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.healthScore,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              stats.healthScore.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SectionHeader(title: loc.quickCards),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.2,
                    children: [
                      QuickStatCard(
                        title: loc.battery,
                        value: '${stats.batteryLevel}%',
                        status: batteryStatus.text,
                        statusColor: batteryStatus.color,
                        icon: Icons.battery_full,
                      ),
                      QuickStatCard(
                        title: loc.storage,
                        value:
                            '${stats.storageUsedGb.toStringAsFixed(0)}/${stats.storageTotalGb.toStringAsFixed(0)} GB',
                        status: storageStatus.text,
                        statusColor: storageStatus.color,
                        icon: Icons.sd_storage,
                      ),
                      QuickStatCard(
                        title: loc.memory,
                        value:
                            '${stats.memoryUsedGb.toStringAsFixed(1)}/${stats.memoryTotalGb.toStringAsFixed(1)} GB',
                        status: memoryStatus.text,
                        statusColor: memoryStatus.color,
                        icon: Icons.memory,
                      ),
                      QuickStatCard(
                        title: loc.temperature,
                        value: stats.temperatureC == null
                            ? loc.unknown
                            : '${stats.temperatureC!.toStringAsFixed(1)} C',
                        status: tempStatus.text,
                        statusColor: tempStatus.color,
                        icon: Icons.thermostat,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SectionHeader(title: loc.trend7d),
                  const SizedBox(height: 12),
                  Sparkline(
                    values: data.snapshots.map((s) => s.healthScore).toList(),
                  ),
                  const SizedBox(height: 24),
                  if (data.habitTipKey != null) ...[
                    SectionHeader(title: loc.smartTipTitle),
                    const SizedBox(height: 12),
                    _TipCard(tipKey: data.habitTipKey!),
                    const SizedBox(height: 24),
                  ],
                  SectionHeader(
                    title: loc.proFeatures,
                    trailing: data.isPro
                        ? _ProBadge(text: loc.proActive)
                        : _ProBadge(text: loc.proInactive),
                  ),
                  const SizedBox(height: 12),
                  if (!data.isPro)
                    _LockedCard(
                      title: loc.proRequired,
                      actionLabel: loc.upgrade,
                      onAction: () => context.go('/pro'),
                    )
                  else ...[
                    AgingMeter(metrics: data.agingMetrics),
                    const SizedBox(height: 12),
                    DigitalDnaCard(dna: data.digitalDna),
                    const SizedBox(height: 12),
                    PredictiveWarningsCard(warnings: data.warnings),
                    const SizedBox(height: 12),
                    TimeCapsuleCard(items: data.timeCapsule),
                  ],
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _orbColor(int score) {
    if (score >= 70) return AppColors.good;
    if (score >= 45) return AppColors.warn;
    return AppColors.bad;
  }

  _StatusLabel _statusLabel(
    BuildContext context, {
    required int score,
    required int warnAt,
    required int badAt,
    required bool higherIsBetter,
  }) {
    final loc = AppLocalizations.of(context)!;
    if (higherIsBetter) {
      if (score >= warnAt) {
        return _StatusLabel(text: loc.good, color: AppColors.good);
      }
      if (score >= badAt) {
        return _StatusLabel(text: loc.warn, color: AppColors.warn);
      }
      return _StatusLabel(text: loc.bad, color: AppColors.bad);
    } else {
      if (score >= badAt) {
        return _StatusLabel(text: loc.bad, color: AppColors.bad);
      }
      if (score >= warnAt) {
        return _StatusLabel(text: loc.warn, color: AppColors.warn);
      }
      return _StatusLabel(text: loc.good, color: AppColors.good);
    }
  }
}

class _StatusLabel {
  _StatusLabel({required this.text, required this.color});

  final String text;
  final Color color;
}

class _TipCard extends StatelessWidget {
  const _TipCard({required this.tipKey});

  final String tipKey;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final tipText = _tipForKey(loc, tipKey);
    return Container(
      padding: const EdgeInsets.all(AppDimens.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(AppDimens.radius),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline, color: AppColors.neonSoft),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tipText,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  String _tipForKey(AppLocalizations loc, String key) {
    switch (key) {
      case 'tipCharge':
        return loc.tipCharge;
      case 'tipStorage':
        return loc.tipStorage;
      case 'tipMemory':
        return loc.tipMemory;
      case 'tipHeat':
        return loc.tipHeat;
      default:
        return loc.tipGeneral;
    }
  }
}

class _LockedCard extends StatelessWidget {
  const _LockedCard({
    required this.title,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(AppDimens.radius),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(width: 12),
          FilledButton(
            onPressed: onAction,
            child: Text(actionLabel),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: onRetry,
            child: Text(AppLocalizations.of(context)!.retry),
          ),
        ],
      ),
    );
  }
}

class _ProBadge extends StatelessWidget {
  const _ProBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.neonSoft),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
