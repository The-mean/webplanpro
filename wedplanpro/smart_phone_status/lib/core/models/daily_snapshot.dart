import 'package:hive/hive.dart';

import '../utils/date_utils.dart';
import 'device_stats.dart';

class DailySnapshot {
  DailySnapshot({
    required this.day,
    required this.healthScore,
    required this.batteryLevel,
    required this.storageUsedGb,
    required this.storageTotalGb,
    required this.memoryUsedGb,
    required this.memoryTotalGb,
    required this.temperatureC,
  });

  factory DailySnapshot.fromStats(DeviceStats stats) {
    final day = DateTime(stats.timestamp.year, stats.timestamp.month,
        stats.timestamp.day);
    return DailySnapshot(
      day: day,
      healthScore: stats.healthScore,
      batteryLevel: stats.batteryLevel,
      storageUsedGb: stats.storageUsedGb,
      storageTotalGb: stats.storageTotalGb,
      memoryUsedGb: stats.memoryUsedGb,
      memoryTotalGb: stats.memoryTotalGb,
      temperatureC: stats.temperatureC,
    );
  }

  final DateTime day;
  final int healthScore;
  final int batteryLevel;
  final double storageUsedGb;
  final double storageTotalGb;
  final double memoryUsedGb;
  final double memoryTotalGb;
  final double? temperatureC;

  String get dayKey => dayKeyFromDate(day);
}

String dayKeyFromDate(DateTime date) => dayKey(date);

class DailySnapshotAdapter extends TypeAdapter<DailySnapshot> {
  @override
  final int typeId = 1;

  @override
  DailySnapshot read(BinaryReader reader) {
    final day = reader.readDateTime();
    final healthScore = reader.readInt();
    final batteryLevel = reader.readInt();
    final storageUsedGb = reader.readDouble();
    final storageTotalGb = reader.readDouble();
    final memoryUsedGb = reader.readDouble();
    final memoryTotalGb = reader.readDouble();
    final temperatureC = reader.read() as double?;
    return DailySnapshot(
      day: day,
      healthScore: healthScore,
      batteryLevel: batteryLevel,
      storageUsedGb: storageUsedGb,
      storageTotalGb: storageTotalGb,
      memoryUsedGb: memoryUsedGb,
      memoryTotalGb: memoryTotalGb,
      temperatureC: temperatureC,
    );
  }

  @override
  void write(BinaryWriter writer, DailySnapshot obj) {
    writer.writeDateTime(obj.day);
    writer.writeInt(obj.healthScore);
    writer.writeInt(obj.batteryLevel);
    writer.writeDouble(obj.storageUsedGb);
    writer.writeDouble(obj.storageTotalGb);
    writer.writeDouble(obj.memoryUsedGb);
    writer.writeDouble(obj.memoryTotalGb);
    writer.write(obj.temperatureC);
  }
}
