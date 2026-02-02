import 'package:flutter/material.dart';

import 'package:smart_phone_status/ui/theme/app_colors.dart';
import 'package:smart_phone_status/ui/theme/app_spacing.dart';
import 'package:smart_phone_status/ui/theme/app_text.dart';

class AgingMeterSection extends StatelessWidget {
  const AgingMeterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'PHONE AGING METER',
          trailing: const Icon(
            Icons.history_toggle_off,
            size: 18,
            color: AppColors.neonCyan,
          ),
        ),
        const SizedBox(height: 12),
        const _MeterRow(
          label: 'PHYSICAL AGE',
          value: '2.4Y',
          progress: 0.8,
          active: false,
        ),
        const SizedBox(height: 16),
        const _MeterRow(
          label: 'VIRTUAL AGE // PERF.',
          value: '1.8Y',
          progress: 0.6,
          active: true,
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'OPTIMIZED BY AI CORE',
            style: AppText.hudLabel.copyWith(
              fontSize: 10,
              letterSpacing: 2.2,
              color: AppColors.neonCyan.withOpacity(0.6),
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppText.hudLabel.copyWith(
            fontSize: 12,
            letterSpacing: 2.8,
            color: AppColors.neonCyan,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.cardBorder.withOpacity(0.7),
          ),
        ),
        const SizedBox(width: 12),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _MeterRow extends StatelessWidget {
  const _MeterRow({
    required this.label,
    required this.value,
    required this.progress,
    required this.active,
  });

  final String label;
  final String value;
  final double progress;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final valueColor = active ? AppColors.neonCyan : AppColors.textMuted;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppText.hudLabel.copyWith(
                fontSize: 11.5,
                letterSpacing: 2.4,
                color: AppColors.textMuted,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: AppText.title.copyWith(
                fontSize: 14.5,
                color: valueColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _ThinBar(progress: progress, active: active),
      ],
    );
  }
}

class _ThinBar extends StatefulWidget {
  const _ThinBar({required this.progress, required this.active});

  final double progress;
  final bool active;

  @override
  State<_ThinBar> createState() => _ThinBarState();
}

class _ThinBarState extends State<_ThinBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 0.12, end: 0.28).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glow,
      builder: (context, child) {
        final glowOpacity = widget.active ? _glow.value : 0;
        return LayoutBuilder(
          builder: (context, constraints) {
            final barWidth = constraints.maxWidth;
            return Container(
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textMuted.withOpacity(0.18),
                borderRadius: BorderRadius.circular(AppSpacing.radius),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 4,
                  width: barWidth * widget.progress,
                  decoration: BoxDecoration(
                    color: widget.active
                        ? AppColors.neonCyan.withOpacity(0.9)
                        : AppColors.textMuted.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(AppSpacing.radius),
                    boxShadow: widget.active
                        ? [
                            BoxShadow(
                              color: AppColors.neonCyan
                                  .withOpacity(glowOpacity),
                              blurRadius: 5,
                              spreadRadius: 0,
                            ),
                          ]
                        : null,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
