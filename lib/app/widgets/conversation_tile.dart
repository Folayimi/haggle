import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ConversationTile extends StatelessWidget {
  const ConversationTile({
    super.key,
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
