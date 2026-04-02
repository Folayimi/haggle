import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/app_pill.dart';
import '../../../../widgets/circle_icon_button.dart';
import '../../../../widgets/haggle_button.dart';
import '../../../../widgets/haggle_card.dart';
import '../../../../widgets/info_tile.dart';
import '../../../../widgets/mic_button.dart';
import '../../../../widgets/note_card.dart';
import '../../../../widgets/section_header.dart';
import '../../../../widgets/status_pill.dart';

class NegotiateTab extends StatelessWidget {
  const NegotiateTab({super.key, required this.onMenuTap});

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
                  Text('Negotiate', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                  Text(
                    'Quiet offers, clear answers',
                    style: theme.textTheme.labelMedium?.copyWith(color: AppColors.dark.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            StatusPill(label: 'Live', color: AppColors.primary),
          ],
        ),
        const SizedBox(height: 18),
        HaggleCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current Room', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(
                'Fola Studios is waiting. You have time to respond.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 14),
              Row(
                children: const [
                  InfoTile(label: 'Time left', value: '02:12'),
                  SizedBox(width: 12),
                  InfoTile(label: 'Your offer', value: 'NGN 32k'),
                ],
              ),
              const SizedBox(height: 16),
              const HaggleButton(label: 'Send a calm counter', onPressed: null),
            ],
          ),
        ),
        const SizedBox(height: 16),
        HaggleCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Voice Room', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              Row(
                children: [
                  MicButton(isActive: true, onPressed: () {}),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Speak softly, keep it human. Vendors respond better to clarity.',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const [
                  AppPill(label: 'Match halfway'),
                  AppPill(label: 'Ask for bundle'),
                  AppPill(label: 'Hold offer'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const SectionHeader(title: 'Conversation Notes'),
        const SizedBox(height: 12),
        const NoteCard(
          title: 'Buyer mood',
          body: 'Open to quick close if delivery is included.',
        ),
      ],
    );
  }
}

// StatusPill and NoteCard moved to widgets.
