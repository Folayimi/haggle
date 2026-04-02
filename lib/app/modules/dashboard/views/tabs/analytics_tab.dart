import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/circle_icon_button.dart';
import '../../../../widgets/haggle_card.dart';
import '../../../../widgets/info_tile.dart';
import '../../../../widgets/section_header.dart';
import '../../../../widgets/trust_card.dart';

class AnalyticsTab extends StatelessWidget {
  const AnalyticsTab({super.key, required this.onMenuTap});

  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleIconButton(icon: Icons.menu_rounded, onTap: onMenuTap),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Analytics', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                  Text(
                    'A calm view of your growth',
                    style: theme.textTheme.labelMedium?.copyWith(color: AppColors.dark.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            const CircleIconButton(icon: Icons.file_download_outlined),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: const [
            InfoTile(label: 'Sessions', value: '18'),
            SizedBox(width: 12),
            InfoTile(label: 'Offer rate', value: '22%'),
          ],
        ),
        const SizedBox(height: 18),
        HaggleCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Story of the Week', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text(
                'Buyers stayed longer when you introduced the product story in the first 30 seconds.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 14),
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.neutral),
                ),
                child: const Center(
                  child: Icon(Icons.show_chart_rounded, color: AppColors.secondary, size: 40),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const SectionHeader(title: 'Trust and Safety'),
        const SizedBox(height: 12),
        const TrustCard(
          title: 'Verified buyers',
          value: '86%',
          subtitle: 'Last 30 days',
        ),
        const SizedBox(height: 12),
        const TrustCard(
          title: 'Disputes resolved',
          value: '96%',
          subtitle: 'Calm closures',
        ),
      ],
    );
  }
}

// CircleIconButton and InfoTile live in widgets.

// TrustCard moved to widgets.
