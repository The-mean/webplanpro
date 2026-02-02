import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class StatusOrb extends StatefulWidget {
  const StatusOrb({
    super.key,
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  State<StatusOrb> createState() => _StatusOrbState();
}

class _StatusOrbState extends State<StatusOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.95, end: 1.05).animate(
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScaleTransition(
          scale: _pulse,
          child: Container(
            width: AppDimens.orbSize,
            height: AppDimens.orbSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color.withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.6),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
              ],
              border: Border.all(
                color: widget.color,
                width: 2,
              ),
            ),
            child: Center(
              child: Container(
                width: AppDimens.orbSize * 0.5,
                height: AppDimens.orbSize * 0.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
