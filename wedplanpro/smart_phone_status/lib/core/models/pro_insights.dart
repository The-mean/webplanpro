enum AgingSpeed { slow, normal, fast }

class AgingMetrics {
  AgingMetrics({
    required this.deviceAgeYears,
    required this.performanceAgeYears,
    required this.speed,
  });

  final double deviceAgeYears;
  final double performanceAgeYears;
  final AgingSpeed speed;
}

class DigitalDna {
  DigitalDna({
    required this.profileKey,
    required this.riskKey,
    required this.strengthKey,
  });

  final String profileKey;
  final String riskKey;
  final String strengthKey;
}
