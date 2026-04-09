import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/mock_seller_profiles.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/haggle_button.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<dynamic, dynamic>?;
    final product = args?['product'] as SellerProduct?;
    final seller = args?['seller'] as SellerProfileData?;

    if (product == null || seller == null) {
      return const Scaffold(
        body: Center(child: Text('Product details not available.')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        title: const Text('Product details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: AspectRatio(
                aspectRatio: 1.25,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(color: AppColors.accent),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
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
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          product.category,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        product.price,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.dark.withOpacity(0.7),
                          height: 1.5,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SellerCard(seller: seller),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: HaggleButton(
                    label: 'Order now',
                    icon: Icons.shopping_bag_outlined,
                    onPressed: () {
                      Get.snackbar(
                        'Order started',
                        'We will notify ${seller.name} that you want to order this product.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.white,
                        colorText: AppColors.dark,
                        margin: const EdgeInsets.all(16),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: HaggleButton(
                    label: 'Message owner',
                    icon: Icons.forum_outlined,
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.dark,
                    onPressed: () => Get.toNamed(Routes.CONVERSATION, arguments: seller),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Scheduled live for this product',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            if (seller.upcomingLives.isEmpty)
              Text(
                'No scheduled live sessions yet.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.dark.withOpacity(0.6),
                    ),
              )
            else
              ...seller.upcomingLives.map(
                (live) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _ScheduledLiveCard(live: live),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SellerCard extends StatelessWidget {
  const _SellerCard({required this.seller});

  final SellerProfileData seller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(seller.avatarUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  seller.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 2),
                Text(
                  seller.businessName,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.dark.withOpacity(0.6),
                      ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Get.toNamed(Routes.SELLER_PROFILE, arguments: seller),
            child: const Text('View profile'),
          ),
        ],
      ),
    );
  }
}

class _ScheduledLiveCard extends StatelessWidget {
  const _ScheduledLiveCard({required this.live});

  final SellerLiveSession live;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  live.schedule,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              const Spacer(),
              const Icon(Icons.live_tv_rounded, size: 18, color: AppColors.dark),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            live.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            live.preview,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.dark.withOpacity(0.66),
                  height: 1.4,
                ),
          ),
        ],
      ),
    );
  }
}
