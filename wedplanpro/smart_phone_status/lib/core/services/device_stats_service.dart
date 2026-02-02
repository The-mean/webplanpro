import 'dart:math';

import 'package:flutter/services.dart';

import '../models/device_stats.dart';

class DeviceStatsService {
  static const MethodChannel _channel =
      MethodChannel('smart_phone_status/device_stats');

  Future<DeviceStats> fetchStats() async {
    final now = DateTime.now();
    try {
      final result =
          await _channel.invokeMethod<Map<dynamic, dynamic>>('getStats');
      if (result != null) {
        final stats = _fromMap(result, now);
        return stats;
      }
    } catch (_) {
      // Fall back to local mock values when platform data is unavailable.
    }
    return _mockStats(now);
  }

  DeviceStats _fromMap(Map<dynamic, dynamic> map, DateTime now) {
    final battery = (map['batteryLevel'] as num?)?.toInt() ?? 0;
    final storageUsed = (map['storageUsedGb'] as num?)?.toDouble() ?? 0;
    final storageTotal = (map['storageTotalGb'] as num?)?.toDouble() ?? 0;
    final memoryUsed = (map['memoryUsedGb'] as num?)?.toDouble() ?? 0;
    final memoryTotal = (map['memoryTotalGb'] as num?)?.toDouble() ?? 0;
    final temp = (map['temperatureC'] as num?)?.toDouble();
    final health = _calculateHealthScore(
      batteryLevel: battery,
      storageUsedGb: storageUsed,
      storageTotalGb: storageTotal,
      memoryUsedGb: memoryUsed,
      memoryTotalGb: memoryTotal,
      temperatureC: temp,
    );

    return DeviceStats(
      batteryLevel: battery,
      storageUsedGb: storageUsed,
      storageTotalGb: storageTotal,
      memoryUsedGb: memoryUsed,
      memoryTotalGb: memoryTotal,
      temperatureC: temp,
      healthScore: health,
      timestamp: now,
    );
  }

  DeviceStats _mockStats(DateTime now) {
    final seed = now.year * 10000 + now.month * 100 + now.day;
    final random = Random(seed);
    final battery = 40 + random.nextInt(60);
    final storageTotal = 128.0;
    final storageUsed = 50 + random.nextInt(60);
    final memoryTotal = 8.0;
    final memoryUsed = 2 + random.nextDouble() * 4.5;
    final temp = 30 + random.nextDouble() * 10;
    final health = _calculateHealthScore(
      batteryLevel: battery,
      storageUsedGb: storageUsed,
      storageTotalGb: storageTotal,
      memoryUsedGb: memoryUsed,
      memoryTotalGb: memoryTotal,
      temperatureC: temp,
    );

    return DeviceStats(
      batteryLevel: battery,
      storageUsedGb: storageUsed,
      storageTotalGb: storageTotal,
      memoryUsedGb: memoryUsed,
      memoryTotalGb: memoryTotal,
      temperatureC: temp,
      healthScore: health,
      timestamp: now,
    );
  }

  int _calculateHealthScore({
    required int batteryLevel,
    required double storageUsedGb,
    required double storageTotalGb,
    required double memoryUsedGb,
    required double memoryTotalGb,
    required double? temperatureC,
  }) {
    var score = 100.0;
    score -= (100 - batteryLevel) * 0.3;
    final storagePercent =
        storageTotalGb == 0 ? 0 : (storageUsedGb / storageTotalGb) * 100;
    final memoryPercent =
        memoryTotalGb == 0 ? 0 : (memoryUsedGb / memoryTotalGb) * 100;
    score -= storagePercent * 0.2;
    score -= memoryPercent * 0.2;
    if (temperatureC != null && temperatureC > 35) {
      score -= min((temperatureC - 35) * 2, 20);
    }
    final clamped = score.clamp(0, 100).toInt();
    return clamped;
  }
}

// TODO(android): Android tarafinda MethodChannel ile "getStats" handler ekleyin.
// BatteryManager ile pil yuzdesi, StatFs ile depolama, ActivityManager ile bellek,
// thermal API ile sicaklik degerlerini Map olarak geri dondurun.
