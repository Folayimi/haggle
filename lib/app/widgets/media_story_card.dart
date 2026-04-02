import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class MediaStoryCard extends StatelessWidget {
  const MediaStoryCard({
    super.key,
    required this.label,
    required this.badge,
    required this.viewers,
    required this.imageUrl,
  });

  final String label;
  final String badge;
  final String viewers;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: AppColors.accent);
                },
              ),
            ),
            Positioned.fill(
              child: Container(color: AppColors.dark.withOpacity(0.2)),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      badge,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white),
                    ),
                  ),
                  const Spacer(),
                  Text(label, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.remove_red_eye_outlined, color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                      Text(viewers, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
