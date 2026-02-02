import 'package:flutter/material.dart';

import 'package:smart_phone_status/features/insights/widgets/aging_meter_section.dart';
import 'package:smart_phone_status/features/insights/widgets/digital_dna_section.dart';
import 'package:smart_phone_status/features/insights/widgets/insights_footer.dart';
import 'package:smart_phone_status/features/insights/widgets/insights_top_bar.dart';
import 'package:smart_phone_status/features/insights/widgets/predictive_insights_section.dart';
import 'package:smart_phone_status/features/insights/widgets/subtle_hud_background.dart';
import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Gercek veri baglantilari servis katmanindan alinacak.
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(child: SubtleHudBackground()),
            Column(
              children: [
                const InsightsTopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 8),
                        AgingMeterSection(),
                        SizedBox(height: 28),
                        DigitalDnaSection(),
                        SizedBox(height: 28),
                        PredictiveInsightsSection(),
                        SizedBox(height: 32),
                        InsightsFooter(),
                        SizedBox(height: 24),
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
