import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/circle_icon_button.dart';
import '../../../../widgets/section_header.dart';
import '../../../../widgets/spotlight_card.dart';
import '../../../../widgets/story_bubble.dart';

class MessageTab extends StatelessWidget {
  const MessageTab({super.key, required this.onMenuTap});

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
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Messages', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                  Text(
                    'Keep the haggle human',
                    style: theme.textTheme.labelMedium?.copyWith(color: AppColors.dark.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            const CircleIconButton(icon: Icons.edit_outlined),
          ],
        ),
        const SizedBox(height: 16),
        const SectionHeader(title: 'Discover'),
        const SizedBox(height: 12),
        SizedBox(
          height: 92,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              StoryBubble(
                label: 'Add story',
                icon: Icons.add,
                isAdd: true,
              ),
              SizedBox(width: 10),
              StoryBubble(
                label: 'Briana',
                badge: 'Live',
                imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/74/Portrait_%28Unsplash%29.jpg',
              ),
              SizedBox(width: 10),
              StoryBubble(
                label: 'Jemmie',
                imageUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Portrait_of_a_woman_%28Unsplash%29.jpg/640px-Portrait_of_a_woman_%28Unsplash%29.jpg',
              ),
              SizedBox(width: 10),
              StoryBubble(
                label: 'James',
                imageUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Portrait_of_a_man_%28Unsplash%29.jpg/640px-Portrait_of_a_man_%28Unsplash%29.jpg',
              ),
              SizedBox(width: 10),
              StoryBubble(
                label: 'Roes',
                imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/76/Campfire_%2815621989189%29.jpg',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),        
        TextField(
          decoration: InputDecoration(
            hintText: 'Search conversations',
            prefixIcon: const Icon(Icons.search, color: AppColors.dark),
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
        const SectionHeader(title: 'Conversations'),
        const SizedBox(height: 12),
        const _ConversationTile(
          name: 'Fola Studios',
          message: 'Can we close at ₦42k if pickup is today?',
          time: '2m',
          unread: 2,
          avatarUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/74/Portrait_%28Unsplash%29.jpg',
          status: 'Live • 3:12 left',
        ),
        const SizedBox(height: 12),
        const _ConversationTile(
          name: 'Kola Kicks',
          message: 'Counteroffer sent. Waiting for your response.',
          time: '18m',
          unread: 0,
          avatarUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Portrait_of_a_man_%28Unsplash%29.jpg/640px-Portrait_of_a_man_%28Unsplash%29.jpg',
          status: 'Ends in 20m',
        ),
        const SizedBox(height: 12),
        const _ConversationTile(
          name: 'Cora Studios',
          message: 'Next session is scheduled for 6:00 PM.',
          time: '1h',
          unread: 1,
          avatarUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Portrait_of_a_woman_%28Unsplash%29.jpg/640px-Portrait_of_a_woman_%28Unsplash%29.jpg',
          status: 'Scheduled',
        ),
        const SizedBox(height: 12),
        const _ConversationTile(
          name: 'Budiarti',
          message: 'Offer accepted. Proceed to payment when ready.',
          time: '2h',
          unread: 0,
          avatarUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/76/Campfire_%2815621989189%29.jpg',
          status: 'Deal won',
        ),
      ],
    );
  }
}

class _ActiveChip extends StatelessWidget {
  const _ActiveChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.dark.withOpacity(0.6))),
        ],
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
    required this.avatarUrl,
    required this.status,
  });

  final String name;
  final String message;
  final String time;
  final int unread;
  final String avatarUrl;
  final String status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.accent,
            backgroundImage: NetworkImage(avatarUrl),
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
                        name,
                        style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(time, style: theme.textTheme.labelSmall?.copyWith(color: AppColors.dark.withOpacity(0.6))),
                  ],
                ),
                const SizedBox(height: 6),
                Text(message, style: theme.textTheme.bodySmall),
                const SizedBox(height: 8),
                Text(status, style: theme.textTheme.labelSmall?.copyWith(color: AppColors.primary)),
              ],
            ),
          ),
          if (unread > 0) ...[
            const SizedBox(width: 10),
            Container(
              height: 24,
              width: 24,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                unread.toString(),
                style: theme.textTheme.labelSmall?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
