import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/live_reminder_store.dart';
import '../../../../data/mock_seller_profiles.dart';
import '../../../../routes/app_pages.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/circle_icon_button.dart';

class MarketTab extends StatelessWidget {
  const MarketTab({super.key, required this.onMenuTap});

  final VoidCallback onMenuTap;

  static void _openSellerProfile(SellerProfileData seller) {
    Get.toNamed(Routes.SELLER_PROFILE, arguments: seller);
  }

  static void _joinBuyerLive() {
    Get.toNamed(Routes.NEGOTIATION_ROOM, arguments: {'role': 'buyer'});
  }

  static void _reserveLiveTicket() {
    Get.back();
  }

  static void _showLiveDetails(BuildContext context, _MarketLive marketLive) {
    final theme = Theme.of(context);
    final featureItem = marketLive.seller.products.isNotEmpty ? marketLive.seller.products.first : null;
    final timeValue = marketLive.isOngoing ? '12 min left' : marketLive.live.schedule;
    final participantValue = marketLive.isOngoing ? '124 participants' : '38 interested buyers';
    final reminderId = marketLive.reminderId;

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
                    width: 52,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.neutral,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _openSellerProfile(marketLive.seller),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(marketLive.seller.avatarUrl),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _openSellerProfile(marketLive.seller),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              marketLive.seller.name,
                              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              marketLive.seller.username,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: AppColors.dark.withOpacity(0.62),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: AspectRatio(
                    aspectRatio: 1.45,
                    child: Image.network(
                      featureItem?.imageUrl ?? marketLive.seller.coverImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  marketLive.live.title,
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _LiveMetaTile(
                        label: 'Time left',
                        value: timeValue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _LiveMetaTile(
                        label: 'Participants',
                        value: participantValue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  'About this live',
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  marketLive.live.preview,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.dark.withOpacity(0.76),
                    height: 1.45,
                  ),
                ),
                if (featureItem != null) ...[
                  const SizedBox(height: 18),
                  Text(
                    marketLive.isOngoing ? 'Product being displayed' : 'Product or service to be explained',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${featureItem.name}  |  ${featureItem.price}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.dark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    featureItem.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.dark.withOpacity(0.72),
                      height: 1.4,
                    ),
                  ),
                ],
                const SizedBox(height: 22),
                ValueListenableBuilder<Set<String>>(
                  valueListenable: LiveReminderStore.reminders,
                  builder: (context, reminders, _) {
                    final isReserved = reminders.contains(reminderId);
                    final actionLabel = marketLive.isOngoing
                        ? 'Join live'
                        : isReserved
                            ? 'Ticket reserved'
                            : 'Get ticket';

                    return SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: marketLive.isOngoing
                            ? _joinBuyerLive
                            : () {
                                if (isReserved) {
                                  Get.back();
                                  return;
                                }
                                LiveReminderStore.reserve(reminderId);
                                _reserveLiveTicket();
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
                          backgroundColor: marketLive.isOngoing || !isReserved ? AppColors.primary : AppColors.dark,
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

  @override
  Widget build(BuildContext context) {
    final sellerProducts = sellerProfiles
        .expand((seller) => seller.products.map((product) => _MarketProduct(product: product, seller: seller)))
        .toList();
    final ongoingLives = sellerProfiles
        .expand((seller) => seller.ongoingLives.map((live) => _MarketLive(live: live, seller: seller, isOngoing: true)))
        .toList();
    final scheduledLives = sellerProfiles
        .expand((seller) => seller.upcomingLives.map((live) => _MarketLive(live: live, seller: seller, isOngoing: false)))
        .toList();

    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.lightBackground,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 128,
              flexibleSpace: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          CircleIconButton(
                            icon: Icons.menu_rounded,
                            onTap: onMenuTap,
                          ),
                          const Spacer(),
                          CircleIconButton(
                            icon: Icons.notifications_none_rounded,
                            onTap: () => Get.toNamed(Routes.REMINDERS),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search products, sellers, services, or live schedules',
                          prefixIcon: const Icon(Icons.search, color: AppColors.dark),
                          suffixIcon: const Icon(Icons.tune_rounded, color: AppColors.dark),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Trending live',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.dark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 188,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: ongoingLives.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) => SizedBox(
                          width: 208,
                          child: _TrendingLiveCard(
                            live: ongoingLives[index],
                            onTap: () => _showLiveDetails(context, ongoingLives[index]),
                            onSellerTap: () => _openSellerProfile(ongoingLives[index].seller),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _MarketTabBarDelegate(
                const TabBar(
                  padding: EdgeInsets.symmetric(horizontal: 16),
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
            _ProductsMarketView(products: sellerProducts),
            _LivesMarketView(
              lives: ongoingLives,
              onLiveTap: (live) => _showLiveDetails(context, live),
              onSellerTap: _openSellerProfile,
            ),
            _LivesMarketView(
              lives: scheduledLives,
              onLiveTap: (live) => _showLiveDetails(context, live),
              onSellerTap: _openSellerProfile,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductsMarketView extends StatelessWidget {
  const _ProductsMarketView({required this.products});

  final List<_MarketProduct> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const PageStorageKey('market-products'),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 96),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) => _MarketProductCard(
        product: products[index],
        onSellerTap: () => MarketTab._openSellerProfile(products[index].seller),
      ),
    );
  }
}

class _LivesMarketView extends StatelessWidget {
  const _LivesMarketView({
    required this.lives,
    required this.onLiveTap,
    required this.onSellerTap,
  });

  final List<_MarketLive> lives;
  final ValueChanged<_MarketLive> onLiveTap;
  final ValueChanged<SellerProfileData> onSellerTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<String>>(
      valueListenable: LiveReminderStore.reminders,
      builder: (context, reminders, _) {
        return GridView.builder(
          key: PageStorageKey('market-lives-${lives.length}-${lives.isNotEmpty && lives.first.isOngoing}'),
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 96),
          itemCount: lives.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) => _MarketLiveGridCard(
            live: lives[index],
            isReserved: reminders.contains(lives[index].reminderId),
            onTap: () => onLiveTap(lives[index]),
            onSellerTap: () => onSellerTap(lives[index].seller),
          ),
        );
      },
    );
  }
}

class _TrendingLiveCard extends StatelessWidget {
  const _TrendingLiveCard({
    required this.live,
    required this.onTap,
    required this.onSellerTap,
  });

  final _MarketLive live;
  final VoidCallback onTap;
  final VoidCallback onSellerTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final coverImage = live.seller.products.isNotEmpty ? live.seller.products.first.imageUrl : live.seller.coverImageUrl;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                coverImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(color: AppColors.accent),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.08),
                      Colors.black.withOpacity(0.66),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'Live',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onSellerTap,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(live.seller.avatarUrl),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: onSellerTap,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  live.seller.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  live.live.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: Colors.white.withOpacity(0.84),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MarketProductCard extends StatelessWidget {
  const _MarketProductCard({
    required this.product,
    required this.onSellerTap,
  });

  final _MarketProduct product;
  final VoidCallback onSellerTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: AppColors.accent),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        product.product.category,
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
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: onSellerTap,
                    child: Text(
                      product.seller.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.dark.withOpacity(0.62),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    product.product.price,
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

class _MarketLiveGridCard extends StatelessWidget {
  const _MarketLiveGridCard({
    required this.live,
    required this.isReserved,
    required this.onTap,
    required this.onSellerTap,
  });

  final _MarketLive live;
  final bool isReserved;
  final VoidCallback onTap;
  final VoidCallback onSellerTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final coverImage = live.seller.products.isNotEmpty ? live.seller.products.first.imageUrl : live.seller.coverImageUrl;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                coverImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(color: AppColors.accent),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.05),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: live.isOngoing
                            ? AppColors.primary
                            : isReserved
                                ? AppColors.dark
                                : Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        live.isOngoing
                            ? 'Live'
                            : isReserved
                                ? 'Ticket reserved'
                                : live.live.schedule,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: live.isOngoing || isReserved ? Colors.white : AppColors.dark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      live.live.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onSellerTap,
                          child: CircleAvatar(
                            radius: 14,
                            backgroundImage: NetworkImage(live.seller.avatarUrl),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: onSellerTap,
                            child: Text(
                              live.seller.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.white.withOpacity(0.86),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiveMetaTile extends StatelessWidget {
  const _LiveMetaTile({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F5F1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppColors.dark.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _MarketTabBarDelegate extends SliverPersistentHeaderDelegate {
  const _MarketTabBarDelegate(this.tabBar);

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
  bool shouldRebuild(covariant _MarketTabBarDelegate oldDelegate) => false;
}

class _MarketProduct {
  const _MarketProduct({
    required this.product,
    required this.seller,
  });

  final SellerProduct product;
  final SellerProfileData seller;
}

class _MarketLive {
  const _MarketLive({
    required this.live,
    required this.seller,
    required this.isOngoing,
  });

  final SellerLiveSession live;
  final SellerProfileData seller;
  final bool isOngoing;

  String get reminderId => buildLiveReminderId(
        sellerUsername: seller.username,
        liveTitle: live.title,
        schedule: live.schedule,
      );
}
