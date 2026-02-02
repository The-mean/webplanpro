import 'package:flutter/material.dart';

import 'package:smart_phone_status/features/home/widgets/bottom_hud_nav.dart';
import 'package:smart_phone_status/features/home/widgets/metric_grid.dart';
import 'package:smart_phone_status/features/home/widgets/status_orb_section.dart';
import 'package:smart_phone_status/features/home/widgets/status_text.dart';
import 'package:smart_phone_status/features/home/widgets/top_bar.dart';
import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Gerçek cihaz metrikleri servis katmanından bağlanacak.
    const score = 98;
    final metrics = [
      MetricData.battery(level: 82),
      MetricData.storage(totalGb: 128, usedPercent: 62),
      MetricData.memory(usedGb: 4.2, totalGb: 8),
      MetricData.cpuTemp(celsius: 34),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const TopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    StatusOrbSection(score: score),
                    const SizedBox(height: 20),
                    const StatusText(
                      title: 'SYSTEM OPTIMAL',
                      subtitle:
                          'ALL SUBSYSTEMS PERFORMING WITHIN NORMAL PARAMETERS',
                    ),
                    const SizedBox(height: 28),
                    MetricGrid(metrics: metrics),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const BottomHudNav(),
          ],
        ),
      ),
    );
  }
}
