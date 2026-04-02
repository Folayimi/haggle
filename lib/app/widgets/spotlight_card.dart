import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SpotlightCard extends StatelessWidget {
  const SpotlightCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.handle,
    required this.description,
    required this.likes,
    required this.comments,
    required this.shares,
  });

  final String imageUrl;
  final String title;
  final String handle;
  final String description;
  final String likes;
  final String comments;
  final String shares;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.dark.withOpacity(0.2),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        handle,
                        style: theme.textTheme.labelSmall?.copyWith(color: Colors.white.withOpacity(0.85)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.9)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  children: [
                    _MetricIcon(icon: Icons.favorite_border, value: likes),
                    const SizedBox(height: 8),
                    _MetricIcon(icon: Icons.chat_bubble_outline, value: comments),
                    const SizedBox(height: 8),
                    _MetricIcon(icon: Icons.bookmark_border, value: shares),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricIcon extends StatelessWidget {
  const _MetricIcon({required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
