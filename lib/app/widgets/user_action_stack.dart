import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class UserActionStack extends StatelessWidget {
  const UserActionStack({
    super.key,
    required this.userImageUrl,
    required this.likes,
    required this.comments,
    required this.offers,
  });

  final String userImageUrl;
  final String likes;
  final String comments;
  final String offers;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _FollowAvatar(imageUrl: userImageUrl),
        const SizedBox(height: 16),
        _ActionIcon(icon: Icons.favorite_border, label: likes),
        const SizedBox(height: 16),
        _ActionIcon(icon: Icons.chat_bubble_outline, label: comments),
        const SizedBox(height: 16),
        _ActionIcon(icon: Icons.local_offer_outlined, label: offers),
        const SizedBox(height: 16),
        const _ActionIcon(icon: Icons.share_outlined, label: 'Share'),
      ],
    );
  }
}

class _FollowAvatar extends StatelessWidget {
  const _FollowAvatar({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 18,
          width: 18,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: const Icon(Icons.add, size: 12, color: Colors.white),
        ),
      ],
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.4)),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
