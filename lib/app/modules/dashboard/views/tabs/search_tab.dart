import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/circle_icon_button.dart';
import '../../../../widgets/media_story_card.dart';
import '../../../../widgets/trending_media_card.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key, required this.onMenuTap});

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
            const Spacer(),
            const CircleIconButton(icon: Icons.notifications_none_rounded),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: const Icon(Icons.search, color: AppColors.dark),
            suffixIcon: const Icon(Icons.tune, color: AppColors.dark),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: AppColors.neutral),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              MediaStoryCard(
                label: 'Robbinson',
                badge: 'Live',
                viewers: '12k',
                imageUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/7/76/Campfire_%2815621989189%29.jpg',
              ),
              SizedBox(width: 12),
              MediaStoryCard(
                label: 'Nathan S',
                badge: 'Premier',
                viewers: '8k',
                imageUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Cozy_interior_with_a_sofa_%28Unsplash%29.jpg/960px-Cozy_interior_with_a_sofa_%28Unsplash%29.jpg',
              ),
              SizedBox(width: 12),
              MediaStoryCard(
                label: 'Budiarti',
                badge: 'Live',
                viewers: '9k',
                imageUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/7/71/Coffee_%28Unsplash%29.jpg',
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Trending',
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        const TrendingMediaCard(
          title: 'Samantha Raol',
          subtitle: 'Soft layers and warm tones. Limited stock today.',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/74/Portrait_%28Unsplash%29.jpg',
        ),
        const SizedBox(height: 12),
        const TrendingMediaCard(
          title: 'Elina Park',
          subtitle: 'Minimal textures and daylight calm.',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Cozy_interior_with_a_sofa_%28Unsplash%29.jpg/1280px-Cozy_interior_with_a_sofa_%28Unsplash%29.jpg',
        ),
        const SizedBox(height: 12),
        const TrendingMediaCard(
          title: 'Juniper Lane',
          subtitle: 'Cold brew moments with soft light.',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/71/Coffee_%28Unsplash%29.jpg',
        ),
      ],
    );
  }
}
