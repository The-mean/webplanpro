import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/models/daily_snapshot.dart';
import 'core/providers.dart';
import 'core/services/local_store.dart';
import 'core/services/subscription_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DailySnapshotAdapter());

  final localStore = LocalStore();
  await localStore.init();

  final subscriptionService = SubscriptionService(localStore);
  await subscriptionService.init();

  runApp(
    ProviderScope(
      overrides: [
        localStoreProvider.overrideWithValue(localStore),
        subscriptionServiceProvider.overrideWithValue(subscriptionService),
      ],
      child: const SmartPhoneStatusApp(),
    ),
  );
}
