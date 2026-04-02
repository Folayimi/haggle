import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class StoryBubble extends StatelessWidget {
  const StoryBubble({
    super.key,
    required this.label,
    this.imageUrl,
    this.icon,
    this.badge,
    this.isAdd = false,
  });

  final String label;
  final String? imageUrl;
  final IconData? icon;
  final String? badge;
  final bool isAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ringColor = isAdd ? AppColors.secondary : AppColors.primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: 58,
              width: 58,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ringColor, width: 2),
              ),
              child: ClipOval(
                child: Container(
                  color: Colors.white,
                  child: imageUrl != null
                      ? Image.network(imageUrl!, fit: BoxFit.cover)
                      : Icon(icon ?? Icons.person_outline, color: AppColors.dark),
                ),
              ),
            ),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge!,
                  style: theme.textTheme.labelSmall?.copyWith(color: AppColors.accent),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(label, style: theme.textTheme.labelSmall?.copyWith(color: AppColors.dark)),
      ],
    );
  }
}
