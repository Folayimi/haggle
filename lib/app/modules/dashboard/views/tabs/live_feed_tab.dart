import 'package:flutter/material.dart';

import '../../../../data/mock_seller_profiles.dart';
import '../../../../widgets/circle_icon_button.dart';
import '../../../../widgets/fullscreen_feed_card.dart';
import '../../../../routes/app_pages.dart';
import 'package:get/get.dart';

class LiveFeedTab extends StatelessWidget {
  const LiveFeedTab({super.key, required this.onMenuTap});

  final VoidCallback onMenuTap;

  static void _joinRoom(String? videoUrl) {
    Get.toNamed(
      Routes.NEGOTIATION_ROOM,
      arguments: {'role': 'buyer', 'sellerVideoUrl': videoUrl},
    );
  }

  static void _openSellerProfile(SellerProfileData seller) {
    Get.toNamed(Routes.SELLER_PROFILE, arguments: seller);
  }

  @override
  Widget build(BuildContext context) {
    final feed = [
      FullscreenFeedCard(
        title: 'Botanica Rose Lamp',
        vendor: 'Nathan Rusl',
        subtitle: 'A soft glow for cozy nights. Limited pieces today.',
        videoUrl:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Orange_flowers_in_macro_%28Unsplash%29.jpg/960px-Orange_flowers_in_macro_%28Unsplash%29.jpg',
        viewers: '12.3k',
        offers: '250',
        saves: '100',
        userImageUrl: sellerProfiles[0].avatarUrl,
        onJoin: () => _joinRoom(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        ),
        onSellerTap: () => _openSellerProfile(sellerProfiles[0]),
      ),
      FullscreenFeedCard(
        title: 'Campfire Speaker Set',
        vendor: 'Robbinson',
        subtitle: 'Warm sound and calm glow. Offer ends soon.',
        videoUrl:
            'https://videos.pexels.com/video-files/2450251/2450251-uhd_3840_2160_30fps.mp4',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/7/76/Campfire_%2815621989189%29.jpg',
        viewers: '9.1k',
        offers: '180',
        saves: '72',
        userImageUrl: sellerProfiles[1].avatarUrl,
        onJoin: () => _joinRoom(
          'https://videos.pexels.com/video-files/2450251/2450251-uhd_3840_2160_30fps.mp4',
        ),
        onSellerTap: () => _openSellerProfile(sellerProfiles[1]),
      ),
      FullscreenFeedCard(
        title: 'Ceramic Brew Kit',
        vendor: 'Budiarti',
        subtitle: 'Handmade set, small batch. Slow and steady haggles.',
        videoUrl:
            'https://samplefile.com/samples/download/video/mp4/mp4_h264_aac_360p_sample.mp4',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/7/71/Coffee_%28Unsplash%29.jpg',
        viewers: '8.4k',
        offers: '96',
        saves: '41',
        userImageUrl: sellerProfiles[2].avatarUrl,
        onJoin: () => _joinRoom(
          'https://samplefile.com/samples/download/video/mp4/mp4_h264_aac_360p_sample.mp4',
        ),
        onSellerTap: () => _openSellerProfile(sellerProfiles[2]),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox.expand(
          child: Stack(
            children: [
              PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: feed.length,
                itemBuilder: (context, index) {
                  return feed[index];
                },
              ),
              Positioned(
                top: 0,
                left: 0,
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: CircleIconButton(
                      icon: Icons.menu_rounded,
                      onTap: onMenuTap,
                    ),
                  ),
                ),
              ),
              const Positioned(
                top: 0,
                right: 0,
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircleIconButton(icon: Icons.notifications_none_rounded),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// FullscreenFeedCard lives in widgets.
