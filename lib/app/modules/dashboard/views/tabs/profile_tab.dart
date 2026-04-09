import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/mock_seller_profiles.dart';
import '../../../../routes/app_pages.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/circle_icon_button.dart';
import '../../../../widgets/haggle_button.dart';
import '../../../../widgets/profile_widgets.dart';
import '../../../../widgets/profile_tab_sections.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key, required this.onMenuTap});

  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final seller = sellerProfiles.first;

    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 260,
                        width: double.infinity,
                        child: Image.network(
                          seller.coverImageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.12),
                                Colors.black.withOpacity(0.58),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        left: 16,
                        child: CircleIconButton(
                          icon: Icons.menu_rounded,
                          onTap: onMenuTap,
                          backgroundColor: Colors.white.withOpacity(0.16),
                          borderColor: Colors.white.withOpacity(0.14),
                          iconColor: Colors.white,
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: CircleIconButton(
                          icon: Icons.settings_outlined,
                          backgroundColor: Colors.white.withOpacity(0.16),
                          borderColor: Colors.white.withOpacity(0.14),
                          iconColor: Colors.white,
                        ),
                      ),
                      Positioned(
                        left: 20,
                        right: 20,
                        bottom: 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.18),
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                radius: 34,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(seller.avatarUrl),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ariyo Fola',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Fola Studio House  |  @hagglefola',
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: const [
                            _ProfileInfoPill(
                              icon: Icons.verified_outlined,
                              label: 'Verified seller',
                            ),
                            _ProfileInfoPill(
                              icon: Icons.storefront_outlined,
                              label: 'Warm decor studio',
                            ),
                            _ProfileInfoPill(
                              icon: Icons.people_outline,
                              label: '2.4k active followers',
                            ),
                            _ProfileInfoPill(
                              icon: Icons.schedule_rounded,
                              label: 'Replies in 8 min',
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Home styling seller focused on warm lighting, compact decor bundles, and clean live negotiation experiences.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.dark.withOpacity(0.82),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: AppColors.neutral),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'What your profile highlights',
                                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Ambient lamps, artisan decor, live negotiation sessions, and curated home styling drops.',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.dark.withOpacity(0.72),
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.neutral),
                          ),
                          child: Row(
                            children: const [
                              Expanded(
                                child: _ProfileMetricBlock(
                                  label: 'Past Haggles',
                                  value: '240',
                                ),
                              ),
                              _ProfileMetricDivider(),
                              Expanded(
                                child: _ProfileMetricBlock(
                                  label: 'Items Posted',
                                  value: '58',
                                ),
                              ),
                              _ProfileMetricDivider(),
                              Expanded(
                                child: _ProfileMetricBlock(
                                  label: 'Deals Won',
                                  value: '32',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: HaggleButton(
                                label: 'Edit profile',
                                icon: Icons.edit_outlined,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _SecondaryProfileAction(
                                label: 'Share profile',
                                icon: Icons.ios_share_outlined,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _ProfileTabBarDelegate(
                const TabBar(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  indicatorColor: AppColors.dark,
                  indicatorWeight: 2.5,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppColors.dark,
                  unselectedLabelColor: Color(0xFF8B8B8B),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                  tabs: [
                    Tab(text: 'Products'),
                    Tab(text: 'Negotiations'),
                    Tab(text: 'Saved'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          children: [
            GridView.builder(
              key: const PageStorageKey('profile-products'),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 96),
              itemCount: seller.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.69,
              ),
              itemBuilder: (context, index) => _ProfileProductCard(product: seller.products[index]),
            ),
            ListView(
              key: const PageStorageKey('profile-negotiations'),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 96),
              children: [
                HaggleButton(
                  label: 'Start live session',
                  icon: Icons.video_call,
                  onPressed: () => Get.toNamed(
                    Routes.NEGOTIATION_ROOM,
                    arguments: {'role': 'seller'},
                  ),
                ),
                const SizedBox(height: 16),
                const _SectionTitle(title: 'Performance'),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Expanded(child: _InsightTile(label: 'Session Duration', value: '3m 42s')),
                    SizedBox(width: 12),
                    Expanded(child: _InsightTile(label: 'Offer Accept Rate', value: '24%')),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Expanded(child: _InsightTile(label: 'Voice Connect', value: '67%')),
                    SizedBox(width: 12),
                    Expanded(child: _InsightTile(label: 'Day 7 Retention', value: '34%')),
                  ],
                ),
                const SizedBox(height: 18),
                const _SectionTitle(title: 'Upcoming live negotiations'),
                const SizedBox(height: 12),
                const UpcomingCard(
                  title: 'Weekend Market: Vintage Lamp',
                  time: 'Sat | 7:30 PM',
                  status: 'Scheduled',
                ),
                const SizedBox(height: 12),
                const UpcomingCard(
                  title: 'Boutique Drop: Leather Bag',
                  time: 'Sun | 6:00 PM',
                  status: 'Notify me',
                ),
                const SizedBox(height: 18),
                const _SectionTitle(title: 'Recent rooms'),
                const SizedBox(height: 12),
                const MiniMediaGrid(),
              ],
            ),
            ListView(
              key: const PageStorageKey('profile-saved'),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 96),
              children: [
                const _SectionTitle(title: 'Saved deals'),
                const SizedBox(height: 12),
                const SavedDealCard(
                  title: 'Ceramic Brew Kit',
                  vendor: 'Budiarti',
                  status: 'Offer in progress',
                ),
                const SizedBox(height: 12),
                const SavedDealCard(
                  title: 'Gallery Wall Set',
                  vendor: 'Lola Studios',
                  status: 'Waiting for vendor',
                ),
                const SizedBox(height: 12),
                const SavedDealCard(
                  title: 'Vintage Camera Bundle',
                  vendor: 'Fola Studios',
                  status: 'Ready to haggle',
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.neutral),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account tools',
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Quick access to the authentication screens while you continue refining the seller experience.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.dark.withOpacity(0.65),
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 16),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileInfoPill extends StatelessWidget {
  const _ProfileInfoPill({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _ProfileMetricBlock extends StatelessWidget {
  const _ProfileMetricBlock({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.dark,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelSmall?.copyWith(
            color: AppColors.dark.withOpacity(0.66),
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

class _ProfileMetricDivider extends StatelessWidget {
  const _ProfileMetricDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 44,
      color: AppColors.neutral,
    );
  }
}

class _SecondaryProfileAction extends StatelessWidget {
  const _SecondaryProfileAction({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: AppColors.dark),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.dark,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _ProfileProductCard extends StatelessWidget {
  const _ProfileProductCard({required this.product});

  final SellerProduct product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.accent,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.92),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        product.category,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppColors.dark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Text(
                      product.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.dark.withOpacity(0.7),
                        height: 1.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        product.price,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.dark,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'Live ready',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightTile extends StatelessWidget {
  const _InsightTile({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppColors.dark.withOpacity(0.6),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppColors.dark,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
    );
  }
}

class _ProfileTabBarDelegate extends SliverPersistentHeaderDelegate {
  const _ProfileTabBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height + 8;

  @override
  double get maxExtent => tabBar.preferredSize.height + 8;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.lightBackground,
      alignment: Alignment.centerLeft,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _ProfileTabBarDelegate oldDelegate) => false;
}
