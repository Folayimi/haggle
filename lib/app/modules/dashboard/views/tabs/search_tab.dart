import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/circle_icon_button.dart';

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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
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
              _StoryCard(
                label: 'Robbinson',
                badge: 'Live',
                viewers: '12k',
                imageUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/7/76/Campfire_%2815621989189%29.jpg',
              ),
              SizedBox(width: 12),
              _StoryCard(
                label: 'Nathan S',
                badge: 'Premier',
                viewers: '8k',
                imageUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Cozy_interior_with_a_sofa_%28Unsplash%29.jpg/960px-Cozy_interior_with_a_sofa_%28Unsplash%29.jpg',
              ),
              SizedBox(width: 12),
              _StoryCard(
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
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        const _TrendingCard(
          title: 'Samantha Raol',
          subtitle: 'Soft layers and warm tones. Limited stock today.',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/7/74/Portrait_%28Unsplash%29.jpg',
        ),
        const SizedBox(height: 12),
        const _TrendingCard(
          title: 'Elina Park',
          subtitle: 'Minimal textures and daylight calm.',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Cozy_interior_with_a_sofa_%28Unsplash%29.jpg/1280px-Cozy_interior_with_a_sofa_%28Unsplash%29.jpg',
        ),
        const SizedBox(height: 12),
        const _TrendingCard(
          title: 'Juniper Lane',
          subtitle: 'Cold brew moments with soft light.',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/7/71/Coffee_%28Unsplash%29.jpg',
        ),
      ],
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
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
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.dark.withOpacity(0.2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      badge,
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: Colors.white),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    label,
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        viewers,
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall?.copyWith(color: Colors.white),
                      ),
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

class _TrendingCard extends StatelessWidget {
  const _TrendingCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  final String title;
  final String subtitle;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.neutral),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.accent,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.portrait_outlined,
                          color: AppColors.secondary,
                          size: 48,
                        ),
                      );
                    },
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.dark.withOpacity(0.18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [                      
                      SizedBox(height:150),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person_outline, color: AppColors.dark),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  subtitle,
                                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: const [
                              Icon(Icons.favorite_border, color: Colors.white),
                              SizedBox(height: 6),
                              Text('12.3k', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
