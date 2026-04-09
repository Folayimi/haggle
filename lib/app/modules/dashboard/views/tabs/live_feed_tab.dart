import 'package:flutter/material.dart';

import '../../../../data/mock_seller_profiles.dart';
import '../../../../widgets/circle_icon_button.dart';
import '../../../../widgets/fullscreen_feed_card.dart';
import '../../../../routes/app_pages.dart';
import 'package:get/get.dart';

class LiveFeedTab extends StatelessWidget {
  const LiveFeedTab({super.key, required this.onMenuTap});

  final VoidCallback onMenuTap;

  static void _joinRoom() {
    Get.toNamed(Routes.NEGOTIATION_ROOM, arguments: {'role': 'buyer'});
  }

  static void _openSellerProfile(SellerProfileData seller) {
    Get.toNamed(Routes.SELLER_PROFILE, arguments: seller);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final feed = [
      FullscreenFeedCard(
        title: 'Botanica Rose Lamp',
        vendor: 'Nathan Rusl',
        subtitle: 'A soft glow for cozy nights. Limited pieces today.',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Orange_flowers_in_macro_%28Unsplash%29.jpg/960px-Orange_flowers_in_macro_%28Unsplash%29.jpg',
        viewers: '12.3k',
        offers: '250',
        saves: '100',
        userImageUrl: sellerProfiles[0].avatarUrl,
        onJoin: _joinRoom,
        onSellerTap: () => _openSellerProfile(sellerProfiles[0]),
      ),
      FullscreenFeedCard(
        title: 'Campfire Speaker Set',
        vendor: 'Robbinson',
        subtitle: 'Warm sound and calm glow. Offer ends soon.',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/7/76/Campfire_%2815621989189%29.jpg',
        viewers: '9.1k',
        offers: '180',
        saves: '72',
        userImageUrl: sellerProfiles[1].avatarUrl,
        onJoin: _joinRoom,
        onSellerTap: () => _openSellerProfile(sellerProfiles[1]),
      ),
      FullscreenFeedCard(
        title: 'Ceramic Brew Kit',
        vendor: 'Budiarti',
        subtitle: 'Handmade set, small batch. Slow and steady haggles.',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/7/71/Coffee_%28Unsplash%29.jpg',
        viewers: '8.4k',
        offers: '96',
        saves: '41',
        userImageUrl: sellerProfiles[2].avatarUrl,
        onJoin: _joinRoom,
        onSellerTap: () => _openSellerProfile(sellerProfiles[2]),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight == double.infinity
            ? size.height
            : constraints.maxHeight;
        return SizedBox(
          height: height,
          width: size.width,
          child: Stack(
            children: [
              PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: feed.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: height,
                    width: size.width,
                    child: feed[index],
                  );
                },
              ),
              Positioned(
                top: 16,
                left: 16,
                child: CircleIconButton(
                  icon: Icons.menu_rounded,
                  onTap: onMenuTap,
                ),
              ),
              const Positioned(
                top: 16,
                right: 16,
                child: CircleIconButton(icon: Icons.notifications_none_rounded),
              ),
            ],
          ),
        );
      },
    );
  }
}

// FullscreenFeedCard lives in widgets.
