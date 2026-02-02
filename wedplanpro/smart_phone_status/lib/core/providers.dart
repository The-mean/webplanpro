import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/device_stats_service.dart';
import 'services/habit_tip_service.dart';
import 'services/local_store.dart';
import 'services/predictive_service.dart';
import 'services/subscription_service.dart';

final localStoreProvider = Provider<LocalStore>((ref) {
  throw UnimplementedError('LocalStore must be overridden');
});

final deviceStatsServiceProvider = Provider<DeviceStatsService>((ref) {
  return DeviceStatsService();
});

final subscriptionServiceProvider = Provider<SubscriptionService>((ref) {
  throw UnimplementedError('SubscriptionService must be overridden');
});

final habitTipServiceProvider = Provider<HabitTipService>((ref) {
  return HabitTipService(ref.read(localStoreProvider));
});

final predictiveServiceProvider = Provider<PredictiveService>((ref) {
  return PredictiveService();
});
