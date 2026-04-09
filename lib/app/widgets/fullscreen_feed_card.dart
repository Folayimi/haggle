import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'user_action_stack.dart';

class FullscreenFeedCard extends StatelessWidget {
  const FullscreenFeedCard({
    super.key,
    required this.title,
    required this.vendor,
    required this.subtitle,
    required this.imageUrl,
    required this.userImageUrl,
    required this.viewers,
    required this.offers,
    required this.saves,
    this.onJoin,
    this.onSellerTap,
  });

  final String title;
  final String vendor;
  final String subtitle;
  final String imageUrl;
  final String userImageUrl;
  final String viewers;
  final String offers;
  final String saves;
  final VoidCallback? onJoin;
  final VoidCallback? onSellerTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: AppColors.accent);
            },
          ),
        ),
        Positioned.fill(
          child: Container(
            color: AppColors.dark.withOpacity(0.3),
          ),
        ),
        SafeArea(
          minimum: const EdgeInsets.fromLTRB(20, 80, 20, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: UserActionStack(
                  userImageUrl: userImageUrl,
                  likes: viewers,
                  comments: offers,
                  offers: saves,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Live now',
                  style: theme.textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              InkWell(
                onTap: onSellerTap,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundImage: NetworkImage(userImageUrl),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'by $vendor',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: Colors.white.withOpacity(0.92),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.open_in_new_rounded,
                        size: 16,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.9)),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: onJoin,
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      'Join negotiation',
                      style: theme.textTheme.labelLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
