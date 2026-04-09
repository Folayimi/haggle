import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/mock_seller_profiles.dart';
import '../../../../routes/app_pages.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/circle_icon_button.dart';

class MessageTab extends StatelessWidget {
  const MessageTab({super.key, required this.onMenuTap});

  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onlineSellers = sellerProfiles;
    final conversations = [
      _ConversationPreview(
        seller: sellerProfiles[0],
        message: 'Can we close at NGN 42k if pickup is today?',
        time: '2m',
        unread: 2,
        isOnline: true,
      ),
      _ConversationPreview(
        seller: sellerProfiles[1],
        message: 'Counteroffer sent. Waiting for your response.',
        time: '18m',
        unread: 0,
        isOnline: true,
      ),
      _ConversationPreview(
        seller: sellerProfiles[2],
        message: 'Next session is scheduled for 6:00 PM.',
        time: '1h',
        unread: 1,
        isOnline: true,
      ),
      _ConversationPreview(
        seller: sellerProfiles[0],
        message: 'Offer accepted. Proceed to payment when ready.',
        time: '2h',
        unread: 0,
        isOnline: false,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleIconButton(icon: Icons.menu_rounded, onTap: onMenuTap),
            const SizedBox(width: 12),
            Text(
              'Messages',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.neutral),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search messages',
              prefixIcon: const Icon(Icons.search, color: AppColors.dark),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Online sellers',
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 94,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: onlineSellers.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final seller = onlineSellers[index];
              return _OnlineSellerBubble(
                seller: seller,
                onTap: () => Get.toNamed(Routes.CONVERSATION, arguments: seller),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Conversations',
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        ...conversations.map(
          (conversation) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: _ConversationRow(
              conversation: conversation,
              onTap: () => Get.toNamed(Routes.CONVERSATION, arguments: conversation.seller),
            ),
          ),
        ),
      ],
    );
  }
}

class _OnlineSellerBubble extends StatelessWidget {
  const _OnlineSellerBubble({
    required this.seller,
    required this.onTap,
  });

  final SellerProfileData seller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 64,
                height: 64,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(seller.avatarUrl),
                ),
              ),
              Positioned(
                right: 4,
                bottom: 4,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: const Color(0xFF27C76F),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 70,
            child: Text(
              seller.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.dark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConversationRow extends StatelessWidget {
  const _ConversationRow({
    required this.conversation,
    required this.onTap,
  });

  final _ConversationPreview conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.accent,
                    backgroundImage: NetworkImage(conversation.seller.avatarUrl),
                  ),
                  if (conversation.isOnline)
                    Positioned(
                      right: 2,
                      bottom: 2,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: const Color(0xFF27C76F),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversation.seller.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        Text(
                          conversation.time,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: AppColors.dark.withOpacity(0.52),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      conversation.message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.dark.withOpacity(0.68),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              if (conversation.unread > 0)
                Container(
                  constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    conversation.unread.toString(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
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

class _ConversationPreview {
  const _ConversationPreview({
    required this.seller,
    required this.message,
    required this.time,
    required this.unread,
    required this.isOnline,
  });

  final SellerProfileData seller;
  final String message;
  final String time;
  final int unread;
  final bool isOnline;
}
