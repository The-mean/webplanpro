import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/daily_snapshot.dart';
import '../../core/models/device_stats.dart';
import '../../core/models/predictive_warning.dart';
import '../../core/models/pro_insights.dart';
import '../../core/models/time_capsule.dart';
import '../../core/providers.dart';
import '../../core/services/device_stats_service.dart';
import '../../core/services/habit_tip_service.dart';
import '../../core/services/local_store.dart';
import '../../core/services/predictive_service.dart';
import '../../core/services/subscription_service.dart';

class DashboardState {
  DashboardState({
    required this.stats,
    required this.snapshots,
    required this.isPro,
    required this.agingMetrics,
    required this.digitalDna,
    required this.warnings,
    required this.timeCapsule,
    required this.habitTipKey,
  });

  final DeviceStats stats;
  final List<DailySnapshot> snapshots;
  final bool isPro;
  final AgingMetrics agingMetrics;
  final DigitalDna digitalDna;
  final List<PredictiveWarning> warnings;
  final List<TimeCapsuleItem> timeCapsule;
  final String? habitTipKey;
}

class DashboardController extends StateNotifier<AsyncValue<DashboardState>> {
  DashboardController({
    required DeviceStatsService deviceStatsService,
    required LocalStore localStore,
    required SubscriptionService subscriptionService,
    required HabitTipService habitTipService,
    required PredictiveService predictiveService,
  })  : _deviceStatsService = deviceStatsService,
        _localStore = localStore,
        _subscriptionService = subscriptionService,
        _habitTipService = habitTipService,
        _predictiveService = predictiveService,
        super(const AsyncValue.loading()) {
    _load();
  }

  final DeviceStatsService _deviceStatsService;
  final LocalStore _localStore;
  final SubscriptionService _subscriptionService;
  final HabitTipService _habitTipService;
  final PredictiveService _predictiveService;

  Future<void> refresh() => _load();

  Future<void> _load() async {
    state = const AsyncValue.loading();
    try {
      final isPro = await _subscriptionService.checkEntitlementIfNeeded();
      final stats = await _deviceStatsService.fetchStats();
      final snapshot = DailySnapshot.fromStats(stats);
      final retentionDays = isPro ? 90 : 7;
      await _localStore.upsertSnapshot(snapshot, retentionDays);
      final snapshots = _localStore.getRecentSnapshots(retentionDays);

      final firstSeen = _localStore.getFirstSeenDay();
      final agingMetrics = _predictiveService.buildAgingMetrics(
        firstSeen: firstSeen,
        stats: stats,
      );
      final digitalDna = _predictiveService.buildDigitalDna(stats);
      final warnings = _predictiveService.buildWarnings(snapshots, stats);
      final timeCapsule = _predictiveService.buildTimeCapsule(snapshots);
      final habitTipKey = _habitTipService.getTipKeyForToday(stats);

      state = AsyncValue.data(
        DashboardState(
          stats: stats,
          snapshots: snapshots,
          isPro: isPro,
          agingMetrics: agingMetrics,
          digitalDna: digitalDna,
          warnings: warnings,
          timeCapsule: timeCapsule,
          habitTipKey: habitTipKey,
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final dashboardControllerProvider =
    StateNotifierProvider<DashboardController, AsyncValue<DashboardState>>(
  (ref) {
    return DashboardController(
      deviceStatsService: ref.read(deviceStatsServiceProvider),
      localStore: ref.read(localStoreProvider),
      subscriptionService: ref.read(subscriptionServiceProvider),
      habitTipService: ref.read(habitTipServiceProvider),
      predictiveService: ref.read(predictiveServiceProvider),
    );
  },
);
