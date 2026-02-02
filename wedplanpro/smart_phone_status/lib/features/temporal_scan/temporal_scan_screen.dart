import 'package:flutter/material.dart';

import 'package:smart_phone_status/features/temporal_scan/widgets/aging_vector_section.dart';
import 'package:smart_phone_status/features/temporal_scan/widgets/health_coherence_orb.dart';
import 'package:smart_phone_status/features/temporal_scan/widgets/subtle_scan_background.dart';
import 'package:smart_phone_status/features/temporal_scan/widgets/system_status_footer.dart';
import 'package:smart_phone_status/features/temporal_scan/widgets/temporal_top_bar.dart';
import 'package:smart_phone_status/features/temporal_scan/widgets/time_range_selector.dart';
import 'package:smart_phone_status/features/temporal_scan/widgets/trend_chart.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';

class TemporalScanScreen extends StatelessWidget {
  const TemporalScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Gercek zaman araligi secimi ve metrikler baglanacak.
    return Scaffold(
      backgroundColor: const Color(0xFF0E1D20),
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(child: SubtleScanBackground()),
            Column(
              children: [
                const TemporalTopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 8),
                        TimeRangeSelector(),
                        SizedBox(height: 24),
                        HealthCoherenceOrb(),
                        SizedBox(height: 24),
                        AgingVectorSection(),
                        SizedBox(height: 18),
                        TrendChart(),
                        SizedBox(height: 24),
                        SystemStatusFooter(),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
