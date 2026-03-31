import 'package:flutter/material.dart';

class AvatarStack extends StatelessWidget {
  const AvatarStack({
    super.key,
    required this.count,
    this.size = 28,
    this.spacing = 14,
  });

  final int count;
  final double size;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visible = count.clamp(0, 4);

    return SizedBox(
      height: size,
      width: size + (visible * spacing),
      child: Stack(
        children: List.generate(visible, (index) {
          return Positioned(
            left: index * spacing,
            child: CircleAvatar(
              radius: size / 2,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.18),
              foregroundColor: theme.colorScheme.primary,
              child: Text(
                String.fromCharCode(65 + index),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
