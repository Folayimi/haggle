import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/circle_icon_button.dart';
import '../../../../widgets/haggle_button.dart';
import '../../../../widgets/section_header.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key, required this.onMenuTap});

  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(24),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Orange_flowers_in_macro_%28Unsplash%29.jpg/960px-Orange_flowers_in_macro_%28Unsplash%29.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                foregroundDecoration: BoxDecoration(
                  color: AppColors.dark.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: CircleIconButton(icon: Icons.chevron_left, onTap: onMenuTap),
              ),
              const Positioned(
                top: 16,
                right: 16,
                child: CircleIconButton(icon: Icons.settings_outlined),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: _EditChip(label: 'Update header'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.neutral),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          'https://upload.wikimedia.org/wikipedia/commons/7/74/Portrait_%28Unsplash%29.jpg',
                        ),
                      ),
                      const _EditBadge(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Ariyo Fola',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '@hagglefola • Active followers 2.4k',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.dark.withOpacity(0.6)),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _StatColumn(label: 'Past Haggles', value: '240'),
                      _StatColumn(label: 'Items Posted', value: '58'),
                      _StatColumn(label: 'Deals Won', value: '32'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Expanded(child: _PrimaryAction(label: 'Update profile')),
                      SizedBox(width: 12),
                      Expanded(child: _SecondaryAction(label: 'Message')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          const TabBar(
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.dark,
            tabs: [
              Tab(text: 'Negotiations'),
              Tab(text: 'Collections'),
              Tab(text: 'Saved'),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 520,
            child: TabBarView(
              children: [
                _NegotiationTabContent(),
                _CollectionsTabContent(),
                _SavedTabContent(),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text('Auth flows', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          HaggleButton(
            label: 'View login',
            onPressed: () => Get.toNamed(Routes.LOGIN),
          ),
          const SizedBox(height: 10),
          HaggleButton(
            label: 'View signup',
            onPressed: () => Get.toNamed(Routes.SIGNUP),
          ),
          const SizedBox(height: 10),
          HaggleButton(
            label: 'View forgot password',
            onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(value, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(label, style: theme.textTheme.labelSmall?.copyWith(color: AppColors.dark.withOpacity(0.6))),
      ],
    );
  }
}

class _PrimaryAction extends StatelessWidget {
  const _PrimaryAction({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(18),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
      ),
    );
  }
}

class _SecondaryAction extends StatelessWidget {
  const _SecondaryAction({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.neutral),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.dark),
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.labelSmall?.copyWith(color: AppColors.dark.withOpacity(0.6))),
          const SizedBox(height: 8),
          Text(value, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _NegotiationTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Haggle KPIs'),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: _HighlightCard(label: 'Session Duration', value: '3m 42s')),
              SizedBox(width: 12),
              Expanded(child: _HighlightCard(label: 'Offer Accept Rate', value: '24%')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: _HighlightCard(label: 'Voice Connect', value: '67%')),
              SizedBox(width: 12),
              Expanded(child: _HighlightCard(label: 'Day 7 Retention', value: '34%')),
            ],
          ),
          const SizedBox(height: 18),
          const SectionHeader(title: 'Upcoming Live Negotiations'),
          const SizedBox(height: 12),
          const _UpcomingCard(
            title: 'Weekend Market: Vintage Lamp',
            time: 'Sat • 7:30 PM',
            status: 'Scheduled',
          ),
          const SizedBox(height: 12),
          const _UpcomingCard(
            title: 'Boutique Drop: Leather Bag',
            time: 'Sun • 6:00 PM',
            status: 'Notify me',
          ),
          const SizedBox(height: 18),
          const SectionHeader(title: 'Recent Rooms'),
          const SizedBox(height: 12),
          const _MiniGrid(),
        ],
      ),
    );
  }
}

class _CollectionsTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SectionHeader(title: 'Collections'),
        SizedBox(height: 12),
        _CollectionCard(
          title: 'Warm Lighting',
          items: '14 items • 6 vendors',
        ),
        SizedBox(height: 12),
        _CollectionCard(
          title: 'Studio Essentials',
          items: '9 items • 4 vendors',
        ),
        SizedBox(height: 12),
        _CollectionCard(
          title: 'Weekend Market Picks',
          items: '12 items • 5 vendors',
        ),
      ],
    );
  }
}

class _SavedTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SectionHeader(title: 'Saved Deals'),
        SizedBox(height: 12),
        _SavedDealCard(
          title: 'Ceramic Brew Kit',
          vendor: 'Budiarti',
          status: 'Offer in progress',
        ),
        SizedBox(height: 12),
        _SavedDealCard(
          title: 'Gallery Wall Set',
          vendor: 'Lola Studios',
          status: 'Waiting for vendor',
        ),
        SizedBox(height: 12),
        _SavedDealCard(
          title: 'Vintage Camera Bundle',
          vendor: 'Fola Studios',
          status: 'Ready to haggle',
        ),
      ],
    );
  }
}

class _MiniGrid extends StatelessWidget {
  const _MiniGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: const [
        _MiniCard(
          title: 'Candlelight Bundle',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/71/Coffee_%28Unsplash%29.jpg',
        ),
        _MiniCard(
          title: 'Garden Glow',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Orange_flowers_in_macro_%28Unsplash%29.jpg/640px-Orange_flowers_in_macro_%28Unsplash%29.jpg',
        ),
        _MiniCard(
          title: 'Calm Workspace',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Cozy_interior_with_a_sofa_%28Unsplash%29.jpg/960px-Cozy_interior_with_a_sofa_%28Unsplash%29.jpg',
        ),
        _MiniCard(
          title: 'Warm Studio',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/76/Campfire_%2815621989189%29.jpg',
        ),
      ],
    );
  }
}

class _UpcomingCard extends StatelessWidget {
  const _UpcomingCard({required this.title, required this.time, required this.status});

  final String title;
  final String time;
  final String status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.live_tv_outlined, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(time, style: theme.textTheme.labelSmall?.copyWith(color: AppColors.dark.withOpacity(0.6))),
              ],
            ),
          ),
          Text(status, style: theme.textTheme.labelSmall?.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  const _CollectionCard({required this.title, required this.items});

  final String title;
  final String items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.collections_bookmark_outlined, color: AppColors.secondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(items, style: theme.textTheme.labelSmall?.copyWith(color: AppColors.dark.withOpacity(0.6))),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.dark),
        ],
      ),
    );
  }
}

class _SavedDealCard extends StatelessWidget {
  const _SavedDealCard({required this.title, required this.vendor, required this.status});

  final String title;
  final String vendor;
  final String status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.bookmark_border, color: AppColors.warning),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('by $vendor', style: theme.textTheme.labelSmall?.copyWith(color: AppColors.dark.withOpacity(0.6))),
              ],
            ),
          ),
          Text(status, style: theme.textTheme.labelSmall?.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }
}

class _EditBadge extends StatelessWidget {
  const _EditBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: const Icon(Icons.edit, size: 12, color: Colors.white),
    );
  }
}

class _EditChip extends StatelessWidget {
  const _EditChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.dark),
      ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  const _MiniCard({required this.title, required this.imageUrl});

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.dark.withOpacity(0.25),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.bottomLeft,
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

// CircleIconButton and AppPill live in widgets.
