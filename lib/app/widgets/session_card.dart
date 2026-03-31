import 'package:flutter/material.dart';

import 'avatar_stack.dart';
import 'price_tag.dart';
import 'timer_pill.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({
    super.key,
    required this.title,
    required this.vendor,
    required this.thumbnail,
    required this.price,
    required this.timeLeft,
    required this.viewers,
  });

  final String title;
  final String vendor;
  final Widget thumbnail;
  final String price;
  final String timeLeft;
  final int viewers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 10,
                  child: thumbnail,
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          theme.colorScheme.surface.withOpacity(0.2),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('by $vendor', style: theme.textTheme.labelMedium),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceTag(amount: price, isEmphasis: true),
                    TimerPill(label: timeLeft),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    AvatarStack(count: viewers),
                    const SizedBox(width: 8),
                    Text('$viewers watching', style: theme.textTheme.labelMedium),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
