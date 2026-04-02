import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  const PriceTag({
    super.key,
    required this.amount,
    this.currency = '₦',
    this.isEmphasis = false,
  });

  final String amount;
  final String currency;
  final bool isEmphasis;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = isEmphasis
        ? theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)
        : theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
      ),
      child: Text(
        '$currency$amount',
        style: style?.copyWith(
          color: theme.colorScheme.primary,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
