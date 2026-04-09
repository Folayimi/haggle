import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/live_reminder_store.dart';
import '../../../data/mock_seller_profiles.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';

class RemindersView extends StatelessWidget {
  const RemindersView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: ValueListenableBuilder<Set<String>>(
          valueListenable: LiveReminderStore.reminders,
          builder: (context, reminders, _) {
            final reservedLives = _buildReservedLives(reminders);

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: AppColors.lightBackground,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  titleSpacing: 0,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        _HeaderIconButton(
                          icon: Icons.arrow_back_ios_new_rounded,
                          onTap: Get.back,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'My Tickets',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                    child: Text(
                      'Reserved live negotiations and reminder access in one place.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.dark.withOpacity(0.66),
                        height: 1.45,
                      ),
                    ),
                  ),
                ),
                if (reservedLives.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.neutral),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: const Icon(
                                Icons.confirmation_num_outlined,
                                color: AppColors.primary,
                                size: 34,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text(
                              'No reserved lives yet',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Get tickets from scheduled lives in Market and they will appear here.',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.dark.withOpacity(0.66),
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                    sliver: SliverList.separated(
                      itemCount: reservedLives.length,
                      itemBuilder: (context, index) {
                        final reminder = reservedLives[index];
                        return _ReminderCard(reminder: reminder);
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<_ReservedLiveItem> _buildReservedLives(Set<String> reminders) {
    final items = <_ReservedLiveItem>[];

    for (final seller in sellerProfiles) {
      for (final live in seller.upcomingLives) {
        final reminderId = buildLiveReminderId(
          sellerUsername: seller.username,
          liveTitle: live.title,
          schedule: live.schedule,
        );
        if (!reminders.contains(reminderId)) {
          continue;
        }

        final featuredProduct = seller.products.isNotEmpty ? seller.products.first : null;
        items.add(
          _ReservedLiveItem(
            seller: seller,
            live: live,
            featuredProduct: featuredProduct,
            reminderId: reminderId,
          ),
        );
      }
    }

    return items;
  }
}

class _ReminderCard extends StatelessWidget {
  const _ReminderCard({required this.reminder});

  final _ReservedLiveItem reminder;

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
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: AspectRatio(
              aspectRatio: 1.8,
              child: Image.network(
                reminder.featuredProduct?.imageUrl ?? reminder.seller.coverImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.accent,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.SELLER_PROFILE, arguments: reminder.seller),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(reminder.seller.avatarUrl),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.toNamed(Routes.SELLER_PROFILE, arguments: reminder.seller),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reminder.seller.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              reminder.seller.username,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: AppColors.dark.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.dark,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'Reserved',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  reminder.live.title,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                Text(
                  reminder.live.schedule,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  reminder.live.preview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.dark.withOpacity(0.72),
                    height: 1.4,
                  ),
                ),
                if (reminder.featuredProduct != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    '${reminder.featuredProduct!.name}  |  ${reminder.featuredProduct!.price}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.dark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, color: AppColors.dark),
        ),
      ),
    );
  }
}

class _ReservedLiveItem {
  const _ReservedLiveItem({
    required this.seller,
    required this.live,
    required this.featuredProduct,
    required this.reminderId,
  });

  final SellerProfileData seller;
  final SellerLiveSession live;
  final SellerProduct? featuredProduct;
  final String reminderId;
}
