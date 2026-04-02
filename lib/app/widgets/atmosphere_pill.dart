import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AtmospherePill extends StatelessWidget {
  const AtmospherePill({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 160,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.storefront_outlined, color: AppColors.secondary),
          const Spacer(),
          Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(subtitle, style: theme.textTheme.labelSmall?.copyWith(color: AppColors.dark.withOpacity(0.6))),
        ],
      ),
    );
  }
}
