import '../models/daily_snapshot.dart';
import '../models/device_stats.dart';
import '../models/predictive_warning.dart';
import '../models/pro_insights.dart';
import '../models/time_capsule.dart';

class PredictiveService {
  AgingMetrics buildAgingMetrics({
    required DateTime firstSeen,
    required DeviceStats stats,
  }) {
    final deviceAgeDays =
        DateTime.now().difference(firstSeen).inDays.clamp(1, 3650);
    final deviceAgeYears = deviceAgeDays / 365;
    final performanceFactor =
        1 + ((100 - stats.healthScore) / 100).clamp(0, 1) * 0.6;
    final performanceAgeYears = deviceAgeYears * performanceFactor;
    final ratio = performanceAgeYears / deviceAgeYears;
    final speed = ratio > 1.1
        ? AgingSpeed.fast
        : ratio < 0.9
            ? AgingSpeed.slow
            : AgingSpeed.normal;
    return AgingMetrics(
      deviceAgeYears: deviceAgeYears,
      performanceAgeYears: performanceAgeYears,
      speed: speed,
    );
  }

  DigitalDna buildDigitalDna(DeviceStats stats) {
    final storage = stats.storageUsedPercent;
    final memory = stats.memoryUsedPercent;
    String profileKey;
    if (storage > 75 && memory > 70) {
      profileKey = 'profileHeavy';
    } else if (storage < 45 && memory < 45) {
      profileKey = 'profileLight';
    } else {
      profileKey = 'profileBalanced';
    }

    final batteryRisk = stats.batteryLevel < 25
        ? 3
        : stats.batteryLevel < 40
            ? 2
            : 0;
    final temp = stats.temperatureC ?? 0;
    final heatRisk = temp > 40
        ? 3
        : temp > 37
            ? 2
            : 0;
    final storageRisk = storage > 85
        ? 3
        : storage > 75
            ? 2
            : 0;

    final riskKey = _maxRiskKey(
      batteryRisk: batteryRisk,
      heatRisk: heatRisk,
      storageRisk: storageRisk,
    );

    final strengthKey =
        stats.healthScore >= 70 ? 'strengthPerformance' : 'strengthStability';

    return DigitalDna(
      profileKey: profileKey,
      riskKey: riskKey,
      strengthKey: strengthKey,
    );
  }

  List<PredictiveWarning> buildWarnings(
    List<DailySnapshot> snapshots,
    DeviceStats stats,
  ) {
    final list = <PredictiveWarning>[];
    if (snapshots.length < 3) {
      return list;
    }
    final recent = snapshots.sublist(
      snapshots.length - 3,
      snapshots.length,
    );
    final first = recent.first;
    final last = recent.last;

    if (last.temperatureC != null && first.temperatureC != null) {
      final delta = last.temperatureC! - first.temperatureC!;
      if (last.temperatureC! > 38 && delta > 1.5) {
        list.add(
          PredictiveWarning(
            titleKey: 'warnHeatTitle',
            detailKey: 'warnHeatDetail',
          ),
        );
      }
    }

    final lastStoragePercent = last.storageTotalGb == 0
        ? 0
        : (last.storageUsedGb / last.storageTotalGb) * 100;
    final firstStoragePercent = first.storageTotalGb == 0
        ? 0
        : (first.storageUsedGb / first.storageTotalGb) * 100;
    final storageDelta = lastStoragePercent - firstStoragePercent;
    final storagePercent = stats.storageUsedPercent;
    if (storagePercent > 80 && storageDelta > 3) {
      list.add(
        PredictiveWarning(
          titleKey: 'warnStorageTitle',
          detailKey: 'warnStorageDetail',
        ),
      );
    }

    final avgBattery =
        (first.batteryLevel + recent[1].batteryLevel + last.batteryLevel) / 3;
    if (avgBattery < 30) {
      list.add(
        PredictiveWarning(
          titleKey: 'warnBatteryTitle',
          detailKey: 'warnBatteryDetail',
        ),
      );
    }
    return list;
  }

  List<TimeCapsuleItem> buildTimeCapsule(
    List<DailySnapshot> snapshots,
  ) {
    if (snapshots.isEmpty) {
      return [
        TimeCapsuleItem(days: 7, deltaScore: null),
        TimeCapsuleItem(days: 30, deltaScore: null),
        TimeCapsuleItem(days: 90, deltaScore: null),
      ];
    }
    final current = snapshots.last;
    return [7, 30, 90].map((days) {
      final target = _findSnapshotDaysAgo(snapshots, days);
      if (target == null) {
        return TimeCapsuleItem(days: days, deltaScore: null);
      }
      final delta = current.healthScore - target.healthScore;
      return TimeCapsuleItem(days: days, deltaScore: delta);
    }).toList();
  }

  DailySnapshot? _findSnapshotDaysAgo(
    List<DailySnapshot> snapshots,
    int days,
  ) {
    final targetDay =
        DateTime.now().subtract(Duration(days: days)).toLocal();
    for (final snapshot in snapshots) {
      if (_sameDay(snapshot.day, targetDay)) {
        return snapshot;
      }
    }
    return null;
  }

  bool _sameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _maxRiskKey({
    required int batteryRisk,
    required int heatRisk,
    required int storageRisk,
  }) {
    if (batteryRisk >= heatRisk && batteryRisk >= storageRisk) {
      return 'riskBattery';
    }
    if (heatRisk >= storageRisk) {
      return 'riskHeat';
    }
    return 'riskStorage';
  }
}
