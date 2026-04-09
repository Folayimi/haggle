import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/live_reminder_store.dart';
import '../../../data/mock_seller_profiles.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/profile_widgets.dart';

class SellerProfileView extends StatefulWidget {
  const SellerProfileView({super.key});

  @override
  State<SellerProfileView> createState() => _SellerProfileViewState();
}

class _SellerProfileViewState extends State<SellerProfileView> {
  bool isFollowing = false;

  SellerProfileData get seller {
    final arguments = Get.arguments;
    if (arguments is SellerProfileData) {
      return arguments;
    }
    return sellerProfiles.first;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: DefaultTabController(
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
                            height: 250,
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
                                    Colors.black.withOpacity(0.55),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            left: 12,
                            child: _GlassIconButton(
                              icon: Icons.arrow_back_ios_new_rounded,
                              onTap: Get.back,
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: const _GlassIconButton(
                              icon: Icons.share_outlined,
                            ),
                          ),
                          Positioned(
                            left: 20,
                            right: 20,
                            bottom: 18,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CircleAvatar(
                                  radius: 34,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(seller.avatarUrl),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        seller.name,
                                        style: theme.textTheme.titleLarge?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${seller.businessName}  |  ${seller.username}',
                                        style: theme.textTheme.labelLarge?.copyWith(
                                          color: Colors.white.withOpacity(0.92),
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
                            Row(
                              children: [
                                Expanded(
                                  child: Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      _InfoPill(
                                        icon: Icons.verified_outlined,
                                        label: seller.tradeMark,
                                      ),
                                      _InfoPill(
                                        icon: Icons.people_outline,
                                        label: '${seller.followers} followers',
                                      ),
                                      _InfoPill(
                                        icon: Icons.star_outline_rounded,
                                        label: '${seller.rating} rating',
                                      ),
                                      _InfoPill(
                                        icon: Icons.schedule_rounded,
                                        label: 'Replies in ${seller.responseTime}',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                _FollowButton(
                                  isFollowing: isFollowing,
                                  onTap: () => setState(() => isFollowing = !isFollowing),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            Text(
                              seller.bio,
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
                                    'What this seller offers',
                                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    seller.sellsSummary,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: AppColors.dark.withOpacity(0.72),
                                      height: 1.45,
                                    ),
                                  ),
                                ],
                              ),
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
                  delegate: _SellerTabBarDelegate(
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
                        Tab(text: 'Ongoing'),
                        Tab(text: 'Scheduled'),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                GridView.builder(
                  key: const PageStorageKey('seller-products'),
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 96),
                  itemCount: seller.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.69,
                  ),
                  itemBuilder: (context, index) {
                    final product = seller.products[index];
                    return _ProductCard(product: product);
                  },
                ),
                ListView(
                  key: const PageStorageKey('seller-ongoing'),
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 96),
                  children: seller.ongoingLives
                      .map(
                        (live) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _LiveSessionCard(
                            live: live,
                            accentColor: AppColors.primary,
                            buttonLabel: 'View live details',
                            onTap: () => _showLiveDetails(context, live),
                          ),
                        ),
                      )
                      .toList(),
                ),
                ValueListenableBuilder<Set<String>>(
                  valueListenable: LiveReminderStore.reminders,
                  builder: (context, reminders, _) {
                    return ListView(
                      key: const PageStorageKey('seller-scheduled'),
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 96),
                      children: seller.upcomingLives
                          .map(
                            (live) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: UpcomingCard(
                                title: live.title,
                                time: live.schedule,
                                status: reminders.contains(
                                  buildLiveReminderId(
                                    sellerUsername: seller.username,
                                    liveTitle: live.title,
                                    schedule: live.schedule,
                                  ),
                                )
                                    ? 'Reminder set'
                                    : live.status,
                                onTap: () => _showLiveDetails(context, live),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLiveDetails(BuildContext context, SellerLiveSession live) {
    final theme = Theme.of(context);
    final isOngoing = live.status.toLowerCase() == 'ongoing';
    final reminderId = buildLiveReminderId(
      sellerUsername: seller.username,
      liveTitle: live.title,
      schedule: live.schedule,
    );
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 54,
                    decoration: BoxDecoration(
                      color: AppColors.neutral,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  live.title,
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                Text(
                  '${live.schedule}  |  ${live.status}',
                  style: theme.textTheme.labelLarge?.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 18),
                Text(
                  'What will be displayed',
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  live.preview,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.dark.withOpacity(0.78),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Benefits for buyers',
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                ...live.buyerBenefits.map(
                  (benefit) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Icon(Icons.check_circle, size: 18, color: AppColors.primary),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            benefit,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.dark.withOpacity(0.8),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                ValueListenableBuilder<Set<String>>(
                  valueListenable: LiveReminderStore.reminders,
                  builder: (context, reminders, _) {
                    final isReserved = reminders.contains(reminderId);
                    final actionLabel = isOngoing
                        ? 'Join live'
                        : isReserved
                            ? 'Ticket reserved'
                            : 'Get ticket';

                    return SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          if (isOngoing) {
                            Get.toNamed(Routes.NEGOTIATION_ROOM, arguments: {'role': 'buyer'});
                            return;
                          }
                          if (isReserved) {
                            Get.back();
                            return;
                          }
                          LiveReminderStore.reserve(reminderId);
                          Get.back();
                          Get.snackbar(
                            'Ticket reserved',
                            'You will be notified a few minutes before and when the negotiation begins.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white,
                            colorText: AppColors.dark,
                            margin: const EdgeInsets.all(16),
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: isOngoing || !isReserved ? AppColors.primary : AppColors.dark,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Text(actionLabel),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  const _GlassIconButton({
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.18),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 44,
          width: 44,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({
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

class _FollowButton extends StatelessWidget {
  const _FollowButton({
    required this.isFollowing,
    required this.onTap,
  });

  final bool isFollowing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isFollowing ? Colors.white : AppColors.primary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isFollowing ? AppColors.neutral : AppColors.primary),
          ),
          child: Text(
            isFollowing ? 'Following' : 'Follow',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isFollowing ? AppColors.dark : Colors.white,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

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
                  Text(
                    product.price,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.dark,
                    ),
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

class _LiveSessionCard extends StatelessWidget {
  const _LiveSessionCard({
    required this.live,
    required this.accentColor,
    required this.buttonLabel,
    required this.onTap,
  });

  final SellerLiveSession live;
  final Color accentColor;
  final String buttonLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  live.status,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                live.schedule,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppColors.dark.withOpacity(0.62),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            live.title,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            live.preview,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.dark.withOpacity(0.74),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    buttonLabel,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SellerTabBarDelegate extends SliverPersistentHeaderDelegate {
  const _SellerTabBarDelegate(this.tabBar);

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
  bool shouldRebuild(covariant _SellerTabBarDelegate oldDelegate) => false;
}
