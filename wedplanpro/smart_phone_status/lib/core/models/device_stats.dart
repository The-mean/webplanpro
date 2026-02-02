class DeviceStats {
  DeviceStats({
    required this.batteryLevel,
    required this.storageUsedGb,
    required this.storageTotalGb,
    required this.memoryUsedGb,
    required this.memoryTotalGb,
    required this.healthScore,
    required this.timestamp,
    this.temperatureC,
  });

  final int batteryLevel;
  final double storageUsedGb;
  final double storageTotalGb;
  final double memoryUsedGb;
  final double memoryTotalGb;
  final double? temperatureC;
  final int healthScore;
  final DateTime timestamp;

  double get storageUsedPercent =>
      storageTotalGb <= 0 ? 0 : (storageUsedGb / storageTotalGb) * 100;

  double get memoryUsedPercent =>
      memoryTotalGb <= 0 ? 0 : (memoryUsedGb / memoryTotalGb) * 100;

  bool get hasTemperature => temperatureC != null;

  DeviceStats copyWith({
    int? batteryLevel,
    double? storageUsedGb,
    double? storageTotalGb,
    double? memoryUsedGb,
    double? memoryTotalGb,
    double? temperatureC,
    int? healthScore,
    DateTime? timestamp,
  }) {
    return DeviceStats(
      batteryLevel: batteryLevel ?? this.batteryLevel,
      storageUsedGb: storageUsedGb ?? this.storageUsedGb,
      storageTotalGb: storageTotalGb ?? this.storageTotalGb,
      memoryUsedGb: memoryUsedGb ?? this.memoryUsedGb,
      memoryTotalGb: memoryTotalGb ?? this.memoryTotalGb,
      temperatureC: temperatureC ?? this.temperatureC,
      healthScore: healthScore ?? this.healthScore,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
