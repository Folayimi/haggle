import 'package:flutter/material.dart';

class OfferStepper extends StatelessWidget {
  const OfferStepper({
    super.key,
    required this.offer,
    required this.onIncrease,
    required this.onDecrease,
  });

  final int offer;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget control(IconData icon, VoidCallback onTap) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.primary.withOpacity(0.25)),
          ),
          child: Icon(icon, size: 16, color: theme.colorScheme.primary),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        control(Icons.remove, onDecrease),
        const SizedBox(width: 12),
        Text(
          '₦$offer',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(width: 12),
        control(Icons.add, onIncrease),
      ],
    );
  }
}
