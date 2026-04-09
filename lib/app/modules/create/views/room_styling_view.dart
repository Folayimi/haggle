import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/haggle_button.dart';

class RoomStylingView extends StatelessWidget {
  const RoomStylingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      onTap: Get.back,
                      borderRadius: BorderRadius.circular(14),
                      child: const SizedBox(
                        width: 42,
                        height: 42,
                        child: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.dark),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Room Styling',
                          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Choose the visual feel buyers step into before your live begins.',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: AppColors.dark.withOpacity(0.62),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const _StyleBoardCard(
                title: 'Boutique calm',
                subtitle: 'Warm tones, clean framing, soft premium energy.',
                color: Color(0xFFEEE4D7),
              ),
              const SizedBox(height: 14),
              const _StyleBoardCard(
                title: 'Studio focus',
                subtitle: 'Minimal setup for clear demos, product angles, and trust.',
                color: Color(0xFFE7ECEC),
              ),
              const SizedBox(height: 14),
              const _StyleBoardCard(
                title: 'Warm social',
                subtitle: 'More energy for active rooms, launch drops, and real-time haggles.',
                color: Color(0xFFFFE7DA),
              ),
              const SizedBox(height: 18),
              const HaggleButton(
                label: 'Apply room styling',
                icon: Icons.auto_awesome_outlined,
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StyleBoardCard extends StatelessWidget {
  const _StyleBoardCard({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.72),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.palette_outlined, color: AppColors.dark),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.dark.withOpacity(0.7),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
