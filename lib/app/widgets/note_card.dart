import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.labelMedium?.copyWith(color: AppColors.dark.withOpacity(0.6))),
          const SizedBox(height: 8),
          Text(body, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
