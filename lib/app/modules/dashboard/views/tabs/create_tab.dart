import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/circle_icon_button.dart';
import '../../../../widgets/atmosphere_pill.dart';
import '../../../../widgets/haggle_button.dart';
import '../../../../widgets/haggle_card.dart';
import '../../../../widgets/info_tile.dart';
import '../../../../widgets/section_header.dart';

class CreateTab extends StatelessWidget {
  const CreateTab({super.key, required this.onMenuTap});

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
                  Text('Create', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                  Text(
                    'Shape the room story',
                    style: theme.textTheme.labelMedium?.copyWith(color: AppColors.dark.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            const CircleIconButton(icon: Icons.auto_awesome_outlined),
          ],
        ),
        const SizedBox(height: 18),
        HaggleCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Session Draft', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(
                'Start with clarity. Buyers respond to transparent ranges.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 14),
              Row(
                children: const [
                  InfoTile(label: 'Start price', value: 'NGN 52k'),
                  SizedBox(width: 12),
                  InfoTile(label: 'Reserve', value: 'NGN 40k'),
                ],
              ),
              const SizedBox(height: 16),
              const HaggleButton(label: 'Set pricing story', onPressed: null),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const SectionHeader(title: 'Atmosphere'),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              AtmospherePill(title: 'Marketplace', subtitle: 'Energetic'),
              SizedBox(width: 10),
              AtmospherePill(title: 'Boutique', subtitle: 'Calm'),
              SizedBox(width: 10),
              AtmospherePill(title: 'Workshop', subtitle: 'Authentic'),
            ],
          ),
        ),
        const SizedBox(height: 18),
        HaggleCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Schedule', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text('Evening sessions convert better in this category.', style: theme.textTheme.bodySmall),
              const SizedBox(height: 14),
              Row(
                children: const [
                  InfoTile(label: 'Duration', value: '30 min'),
                  SizedBox(width: 12),
                  InfoTile(label: 'Notify', value: '2.3k'),
                ],
              ),
              const SizedBox(height: 16),
              const HaggleButton(label: 'Schedule session', onPressed: null),
            ],
          ),
        ),
      ],
    );
  }
}

// CircleIconButton and InfoTile live in widgets.

// AtmospherePill moved to widgets.
