import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/live_reminder_store.dart';
import '../../../../data/market_service.dart';
import '../../../../data/mock_seller_profiles.dart';
import '../../../../routes/app_pages.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/circle_icon_button.dart';

class MarketTab extends StatefulWidget {
  const MarketTab({super.key, required this.onMenuTap});

  final VoidCallback onMenuTap;

  @override
  State<MarketTab> createState() => _MarketTabState();
}

class _MarketTabState extends State<MarketTab> {
  static const _productCategories = [
    'Electronics',
    'Phones & Tablets',
    'Computers & Laptops',
    'TV & Audio',
    'Gaming',
    'Home Appliances',
    'Furniture',
    'Home Decor',
    'Kitchen & Dining',
    'Utensils',
    'Bedding & Bath',
    'Lighting',
    'Tools & Hardware',
    'Garden & Outdoor',
    'Automotive',
    'Cars',
    'Motorcycles',
    'Vehicle Parts & Accessories',
    'Fashion',
    'Men\'s Clothing',
    'Women\'s Clothing',
    'Shoes',
    'Bags & Accessories',
    'Jewelry & Watches',
    'Beauty & Personal Care',
    'Health & Wellness',
    'Baby & Kids',
    'Toys & Games',
    'Books',
    'Stationery',
    'Sports & Fitness',
    'Musical Instruments',
    'Art & Collectibles',
    'Groceries',
    'Pet Supplies',
    'Office Supplies',
    'Industrial & Commercial',
    'Real Estate',
  ];

  static const _serviceCategories = [
    'Carpentry',
    'Tailoring',
    'Road Construction',
    'Architecture',
    'Engineering',
    'Electrical',
    'Plumbing',
    'Painting',
    'Interior Design',
    'Cleaning',
    'Laundry',
    'Moving & Delivery',
    'Vehicle Repair',
    'Phone Repair',
    'Appliance Repair',
    'IT Support',
    'Software Development',
    'Graphic Design',
    'Photography',
    'Videography',
    'Catering',
    'Event Planning',
    'Hair & Makeup',
    'Barbering',
    'Wellness & Spa',
    'Tutoring',
    'Language Lessons',
    'Fitness Training',
    'Legal Services',
    'Accounting',
    'Consulting',
    'Real Estate Services',
    'Security',
    'Gardening',
  ];

  String? _selectedCategory;
  String _searchQuery = '';
  List<String> _recentSearches = [];
  final TextEditingController _searchController = TextEditingController();

  static void _openSellerProfile(SellerProfileData seller) {
    Get.toNamed(Routes.SELLER_PROFILE, arguments: seller);
  }

  static void _openProductDetail(_MarketProduct product) {
    Get.toNamed(
      Routes.PRODUCT_DETAIL,
      arguments: {'product': product.product, 'seller': product.seller},
    );
  }

  static void _openServiceDetail(MarketService service) {
    Get.toNamed(Routes.SERVICE_DETAIL, arguments: service);
  }

  Future<void> _openSearch() async {
    final result = await Get.toNamed(
      Routes.MARKET_SEARCH,
      arguments: {'query': _searchQuery, 'recents': _recentSearches},
    );
    if (!mounted) return;
    if (result is Map) {
      setState(() {
        _searchQuery = (result['query'] ?? '').toString();
        _recentSearches = List<String>.from(
          result['recents'] ?? _recentSearches,
        );
        _searchController.text = _searchQuery;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  static void _joinBuyerLive() {
    Get.toNamed(Routes.NEGOTIATION_ROOM, arguments: {'role': 'buyer'});
  }

  static void _reserveLiveTicket() {
    Get.back();
  }

  static void _showLiveDetails(BuildContext context, _MarketLive marketLive) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final featureItem = marketLive.seller.products.isNotEmpty
        ? marketLive.seller.products.first
        : null;
    final timeValue = marketLive.isOngoing
        ? '12 min left'
        : marketLive.live.schedule;
    final participantValue = marketLive.isOngoing
        ? '124 participants'
        : '38 interested buyers';
    final reminderId = marketLive.reminderId;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
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
                      color: colorScheme.outlineVariant,
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
                        backgroundImage: NetworkImage(
                          marketLive.seller.avatarUrl,
                        ),
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
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              marketLive.seller.username,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.62),
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
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: AppColors.accent),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  marketLive.live.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
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
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  marketLive.live.preview,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.76),
                    height: 1.45,
                  ),
                ),
                if (featureItem != null) ...[
                  const SizedBox(height: 18),
                  Text(
                    marketLive.isOngoing
                        ? 'Product being displayed'
                        : 'Product or service to be explained',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${featureItem.name}  |  ${featureItem.price}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    featureItem.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.72),
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
                                  backgroundColor: colorScheme.surface,
                                  colorText: colorScheme.onSurface,
                                  margin: const EdgeInsets.all(16),
                                );
                              },
                        style: FilledButton.styleFrom(
                          backgroundColor: marketLive.isOngoing || !isReserved
                              ? AppColors.primary
                              : colorScheme.surfaceVariant,
                          foregroundColor: marketLive.isOngoing || !isReserved
                              ? colorScheme.onPrimary
                              : colorScheme.onSurface,
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

  Future<void> _openCategoryPicker(BuildContext context) async {
    final theme = Theme.of(context);
    final selection = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: DefaultTabController(
                length: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 44,
                          height: 4,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.outlineVariant,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Filter by category',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Pick a category to tailor what shows up in your feed.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              Navigator.of(context).pop('All categories'),
                          icon: const Icon(Icons.clear_all_rounded),
                          label: const Text('All categories'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: theme.colorScheme.onSurface,
                            side: BorderSide(
                              color: theme.colorScheme.outlineVariant,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TabBar(
                        labelColor: theme.colorScheme.onSurface,
                        unselectedLabelColor: theme.colorScheme.onSurface
                            .withOpacity(0.55),
                        indicatorColor: theme.colorScheme.onSurface,
                        indicatorWeight: 2.5,
                        tabs: [
                          Tab(text: 'Products'),
                          Tab(text: 'Services'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _CategoryList(categories: _productCategories),
                            _CategoryList(categories: _serviceCategories),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    if (!mounted) return;
    setState(() {
      if (selection == null || selection == 'All categories') {
        _selectedCategory = null;
      } else {
        _selectedCategory = selection;
      }
    });
  }

  bool _matchesCategory(String category, SellerProduct product) {
    final filter = category.toLowerCase();
    final fields = [product.category, product.name, product.description];
    return fields.any((value) => value.toLowerCase().contains(filter));
  }

  bool _matchesSearch(String query, List<String> fields) {
    if (query.isEmpty) return true;
    final filter = query.toLowerCase();
    return fields.any((value) => value.toLowerCase().contains(filter));
  }

  bool _liveMatchesCategory(String category, _MarketLive live) {
    return live.seller.products.any(
      (product) => _matchesCategory(category, product),
    );
  }

  bool _serviceMatchesCategory(String category, MarketService service) {
    final filter = category.toLowerCase();
    final fields = [
      service.category,
      service.name,
      service.description,
      service.seller.name,
      service.seller.businessName,
    ];
    return fields.any((value) => value.toLowerCase().contains(filter));
  }

  List<_MarketLive> _buildTrendingLives(List<_MarketLive> lives) {
    if (lives.isEmpty) return lives;
    const targetCount = 6;
    final expanded = <_MarketLive>[];
    var index = 0;
    while (expanded.length < targetCount) {
      expanded.add(lives[index % lives.length]);
      index++;
    }
    return expanded;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final sellerProducts = sellerProfiles
        .expand(
          (seller) => seller.products.map(
            (product) => _MarketProduct(product: product, seller: seller),
          ),
        )
        .toList();
    final ongoingLives = sellerProfiles
        .expand(
          (seller) => seller.ongoingLives.map(
            (live) => _MarketLive(live: live, seller: seller, isOngoing: true),
          ),
        )
        .toList();
    final scheduledLives = sellerProfiles
        .expand(
          (seller) => seller.upcomingLives.map(
            (live) => _MarketLive(live: live, seller: seller, isOngoing: false),
          ),
        )
        .toList();
    final services = sellerProfiles.asMap().entries.map((entry) {
      final index = entry.key;
      final seller = entry.value;
      final category = _serviceCategories[index % _serviceCategories.length];
      return MarketService(
        name: seller.sellsSummary,
        category: category,
        description: seller.bio,
        price: 'From \$${(120 + (index * 40))}',
        seller: seller,
      );
    }).toList();

    final filteredProducts = _selectedCategory == null
        ? sellerProducts
        : sellerProducts
              .where(
                (entry) => _matchesCategory(_selectedCategory!, entry.product),
              )
              .toList();
    final filteredOngoingLives = _selectedCategory == null
        ? ongoingLives
        : ongoingLives
              .where((live) => _liveMatchesCategory(_selectedCategory!, live))
              .toList();
    final filteredScheduledLives = _selectedCategory == null
        ? scheduledLives
        : scheduledLives
              .where((live) => _liveMatchesCategory(_selectedCategory!, live))
              .toList();
    final filteredServices = _selectedCategory == null
        ? services
        : services
              .where(
                (service) =>
                    _serviceMatchesCategory(_selectedCategory!, service),
              )
              .toList();

    final searchedProducts = _searchQuery.isEmpty
        ? filteredProducts
        : filteredProducts.where((entry) {
            return _matchesSearch(_searchQuery, [
              entry.product.name,
              entry.product.category,
              entry.product.description,
              entry.seller.name,
              entry.seller.businessName,
            ]);
          }).toList();
    final searchedOngoingLives = _searchQuery.isEmpty
        ? filteredOngoingLives
        : filteredOngoingLives.where((live) {
            return _matchesSearch(_searchQuery, [
              live.live.title,
              live.live.preview,
              live.seller.name,
              live.seller.businessName,
            ]);
          }).toList();
    final searchedScheduledLives = _searchQuery.isEmpty
        ? filteredScheduledLives
        : filteredScheduledLives.where((live) {
            return _matchesSearch(_searchQuery, [
              live.live.title,
              live.live.preview,
              live.seller.name,
              live.seller.businessName,
            ]);
          }).toList();
    final searchedServices = _searchQuery.isEmpty
        ? filteredServices
        : filteredServices.where((service) {
            return _matchesSearch(_searchQuery, [
              service.name,
              service.category,
              service.description,
              service.seller.name,
              service.seller.businessName,
            ]);
          }).toList();

    final trendingLives = _buildTrendingLives(searchedOngoingLives);
    final extraHeaderRows =
        (_selectedCategory != null ? 1 : 0) + (_searchQuery.isNotEmpty ? 1 : 0);
    final headerHeight = 70.0 + (extraHeaderRows * 65);

    return DefaultTabController(
      length: 4,
      child: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              final colorScheme = Theme.of(context).colorScheme;
              return [
                SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: colorScheme.background,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  toolbarHeight: headerHeight,
                  flexibleSpace: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              CircleIconButton(
                                icon: Icons.menu_rounded,
                                size: 34,
                                backgroundColor: colorScheme.surface,
                                borderColor: colorScheme.outlineVariant,
                                iconColor: colorScheme.onSurface,
                                onTap: widget.onMenuTap,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  readOnly: true,
                                  onTap: _openSearch,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Search products, sellers, services, or live schedules',
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: colorScheme.onSurface,
                                      size: 18,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.tune_rounded,
                                      color: colorScheme.onSurface,
                                      size: 18,
                                    ),
                                    filled: true,
                                    fillColor: colorScheme.surface,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(
                                        color: colorScheme.outlineVariant,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              CircleIconButton(
                                icon: Icons.notifications_none_rounded,
                                size: 34,
                                backgroundColor: colorScheme.surface,
                                borderColor: colorScheme.outlineVariant,
                                iconColor: colorScheme.onSurface,
                                onTap: () => Get.toNamed(Routes.REMINDERS),
                              ),
                            ],
                          ),
                          if (_selectedCategory != null) ...[
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: colorScheme.outlineVariant,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.filter_list_rounded,
                                    size: 18,
                                    color: colorScheme.onSurface,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Filter: $_selectedCategory',
                                      style: theme.textTheme.labelLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => setState(
                                      () => _selectedCategory = null,
                                    ),
                                    child: const Text('Clear'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          if (_searchQuery.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: colorScheme.outlineVariant,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    size: 18,
                                    color: colorScheme.onSurface,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Search: $_searchQuery',
                                      style: theme.textTheme.labelLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => setState(() {
                                      _searchQuery = '';
                                      _searchController.clear();
                                    }),
                                    child: const Text('Clear'),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Trending live',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          height: 150,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              const sidePadding = 16.0;
                              const itemGap = 10.0;
                              final availableWidth =
                                  constraints.maxWidth -
                                  (sidePadding * 2) -
                                  (itemGap * 2);
                              final cardWidth = availableWidth / 3;
                              return Stack(
                                children: [
                                  ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: sidePadding,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: trendingLives.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(width: itemGap),
                                    itemBuilder: (context, index) => SizedBox(
                                      width: cardWidth,
                                      child: _TrendingLiveCard(
                                        live: trendingLives[index],
                                        onTap: () => _showLiveDetails(
                                          context,
                                          trendingLives[index],
                                        ),
                                        onSellerTap: () => _openSellerProfile(
                                          trendingLives[index].seller,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: IgnorePointer(
                                      child: Container(
                                        width: 28,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              colorScheme.background
                                                  .withOpacity(0),
                                              colorScheme.background,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _MarketTabBarDelegate(
                    TabBar(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      indicatorColor: colorScheme.onSurface,
                      indicatorWeight: 2.5,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: colorScheme.onSurface,
                      unselectedLabelColor: colorScheme.onSurface.withOpacity(
                        0.55,
                      ),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                      tabs: [
                        Tab(text: 'Products'),
                        Tab(text: 'Services'),
                        Tab(text: 'Live'),
                        Tab(text: 'Scheduled'),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                _ProductsMarketView(
                  products: searchedProducts,
                  onSellerTap: _openSellerProfile,
                  onProductTap: _openProductDetail,
                ),
                _ServicesMarketView(
                  services: searchedServices,
                  onSellerTap: _openSellerProfile,
                  onServiceTap: _openServiceDetail,
                ),
                _LivesMarketView(
                  lives: searchedOngoingLives,
                  onLiveTap: (live) => _showLiveDetails(context, live),
                  onSellerTap: _openSellerProfile,
                ),
                _LivesMarketView(
                  lives: searchedScheduledLives,
                  onLiveTap: (live) => _showLiveDetails(context, live),
                  onSellerTap: _openSellerProfile,
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: SafeArea(
              top: false,
              left: false,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: colorScheme.surface.withOpacity(0.92),
                foregroundColor: colorScheme.onSurface,
                onPressed: () => _openCategoryPicker(context),
                child: const Icon(Icons.filter_list_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductsMarketView extends StatelessWidget {
  const _ProductsMarketView({
    required this.products,
    required this.onSellerTap,
    required this.onProductTap,
  });

  final List<_MarketProduct> products;
  final ValueChanged<SellerProfileData> onSellerTap;
  final ValueChanged<_MarketProduct> onProductTap;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('No products match this category right now.'),
        ),
      );
    }
    return GridView.builder(
      key: const PageStorageKey('market-products'),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 96),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) => _MarketProductCard(
        product: products[index],
        onSellerTap: () => onSellerTap(products[index].seller),
        onTap: () => onProductTap(products[index]),
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
    if (lives.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('No live sessions match this category right now.'),
        ),
      );
    }
    return ValueListenableBuilder<Set<String>>(
      valueListenable: LiveReminderStore.reminders,
      builder: (context, reminders, _) {
        return GridView.builder(
          key: PageStorageKey(
            'market-lives-${lives.length}-${lives.isNotEmpty && lives.first.isOngoing}',
          ),
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

class _ServicesMarketView extends StatelessWidget {
  const _ServicesMarketView({
    required this.services,
    required this.onSellerTap,
    required this.onServiceTap,
  });

  final List<MarketService> services;
  final ValueChanged<SellerProfileData> onSellerTap;
  final ValueChanged<MarketService> onServiceTap;

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('No services match this category right now.'),
        ),
      );
    }

    return ListView.separated(
      key: const PageStorageKey('market-services'),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 96),
      itemCount: services.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _MarketServiceCard(
        service: services[index],
        onTap: () => onServiceTap(services[index]),
        onSellerTap: () => onSellerTap(services[index].seller),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({required this.categories});

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => Navigator.of(context).pop(category),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(category, style: theme.textTheme.bodyMedium),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.55),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MarketServiceCard extends StatelessWidget {
  const _MarketServiceCard({
    required this.service,
    required this.onSellerTap,
    required this.onTap,
  });

  final MarketService service;
  final VoidCallback onSellerTap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.design_services_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      service.category,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.7),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    service.price,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                service.name,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                service.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.66),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: onSellerTap,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundImage: NetworkImage(service.seller.avatarUrl),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        service.seller.name,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: colorScheme.onSurface.withOpacity(0.55),
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
    final colorScheme = theme.colorScheme;
    final coverImage = live.seller.products.isNotEmpty
        ? live.seller.products.first.imageUrl
        : live.seller.coverImageUrl;

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
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: AppColors.accent),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
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
                            backgroundImage: NetworkImage(
                              live.seller.avatarUrl,
                            ),
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
    required this.onTap,
  });

  final _MarketProduct product;
  final VoidCallback onSellerTap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        product.product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: AppColors.accent),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.surface.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            product.product.category,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurface,
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
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: onSellerTap,
                        child: Text(
                          product.seller.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.62),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        product.product.price,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
    final colorScheme = theme.colorScheme;
    final coverImage = live.seller.products.isNotEmpty
        ? live.seller.products.first.imageUrl
        : live.seller.coverImageUrl;

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
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: AppColors.accent),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: live.isOngoing
                            ? AppColors.primary
                            : isReserved
                            ? colorScheme.primaryContainer
                            : colorScheme.surface.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        live.isOngoing
                            ? 'Live'
                            : isReserved
                            ? 'Ticket reserved'
                            : live.live.schedule,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: live.isOngoing
                              ? colorScheme.onPrimary
                              : isReserved
                              ? colorScheme.onPrimaryContainer
                              : colorScheme.onSurface,
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
                            backgroundImage: NetworkImage(
                              live.seller.avatarUrl,
                            ),
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
  const _LiveMetaTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
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
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
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
  const _MarketProduct({required this.product, required this.seller});

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
