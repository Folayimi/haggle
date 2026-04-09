import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class UserActionStack extends StatelessWidget {
  const UserActionStack({
    super.key,
    required this.userImageUrl,
    required this.likes,
    required this.comments,
    required this.offers,
    this.compact = false,
  });

  final String userImageUrl;
  final String likes;
  final String comments;
  final String offers;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final avatarSize = compact ? 40.0 : 48.0;
    final actionSize = compact ? 38.0 : 44.0;
    final gap = compact ? 12.0 : 16.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _FollowAvatar(imageUrl: userImageUrl, size: avatarSize),
        SizedBox(height: gap),
        _ActionIcon(icon: Icons.favorite_border, label: likes, size: actionSize),
        SizedBox(height: gap),
        _ActionIcon(icon: Icons.chat_bubble_outline, label: comments, size: actionSize),
        SizedBox(height: gap),
        _ActionIcon(icon: Icons.local_offer_outlined, label: offers, size: actionSize),
        SizedBox(height: gap),
        _ActionIcon(icon: Icons.share_outlined, label: 'Share', size: actionSize),
      ],
    );
  }
}

class _FollowAvatar extends StatelessWidget {
  const _FollowAvatar({required this.imageUrl, required this.size});

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: size,
          width: size,
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
          height: size * 0.38,
          width: size * 0.38,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: Icon(Icons.add, size: size * 0.25, color: Colors.white),
        ),
      ],
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({required this.icon, required this.label, required this.size});

  final IconData icon;
  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.4)),
          ),
          child: Icon(icon, color: Colors.white, size: size * 0.48),
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
