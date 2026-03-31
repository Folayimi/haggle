import 'package:flutter/material.dart';

class TimerPill extends StatelessWidget {
  const TimerPill({
    super.key,
    required this.label,
    this.icon = Icons.timer_outlined,
    this.color,
  });

  final String label;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pillColor = color ?? theme.colorScheme.secondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: pillColor.withOpacity(0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: pillColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: pillColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(color: pillColor),
          ),
        ],
      ),
    );
  }
}
