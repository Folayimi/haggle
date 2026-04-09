import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../theme/app_colors.dart';
import 'user_action_stack.dart';

class FullscreenFeedCard extends StatelessWidget {
  const FullscreenFeedCard({
    super.key,
    required this.title,
    required this.vendor,
    required this.subtitle,
    required this.imageUrl,
    this.videoUrl,
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
  final String? videoUrl;
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
          child: _LiveFeedMedia(
            videoUrl: videoUrl,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: AppColors.dark.withOpacity(0.3),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxHeight < 720;
            final topInset = isCompact ? 56.0 : 64.0;
            final bottomInset = isCompact ? 32.0 : 40.0;
            final contentGap = isCompact ? 8.0 : 10.0;
            final ctaGap = isCompact ? 12.0 : 16.0;
            final headlineStyle = isCompact ? theme.textTheme.titleLarge : theme.textTheme.headlineSmall;

            return SafeArea(
              minimum: EdgeInsets.fromLTRB(20, topInset, 20, bottomInset),
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
                      compact: isCompact,
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
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: contentGap),
                  Text(
                    title,
                    style: headlineStyle?.copyWith(
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
                  SizedBox(height: contentGap),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: ctaGap),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: onJoin,
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          'Join negotiation',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _LiveFeedMedia extends StatefulWidget {
  const _LiveFeedMedia({
    required this.videoUrl,
  });

  final String? videoUrl;

  @override
  State<_LiveFeedMedia> createState() => _LiveFeedMediaState();
}

class _LiveFeedMediaState extends State<_LiveFeedMedia> {
  VideoPlayerController? _controller;
  bool _hasVideoError = false;

  @override
  void initState() {
    super.initState();
    final url = widget.videoUrl;
    if (url == null || url.isEmpty) return;
    _controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..setLooping(true)
      ..setVolume(0);
    _controller!.initialize().then((_) {
      if (!mounted) return;
      _controller!.play();
      setState(() {});
    }).catchError((_) {
      if (!mounted) return;
      setState(() => _hasVideoError = true);
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    if (controller == null || _hasVideoError) {
      return Container(
        color: AppColors.dark,
        alignment: Alignment.center,
        child: const Icon(Icons.videocam_off_rounded, color: Colors.white54, size: 42),
      );
    }

    if (!controller.value.isInitialized) {
      return Container(
        color: AppColors.dark,
        alignment: Alignment.center,
        child: const _SkeletonShimmer(),
      );
    }

    return FittedBox(
      fit: BoxFit.cover,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: controller.value.size.width,
        height: controller.value.size.height,
        child: VideoPlayer(controller),
      ),
    );
  }
}

class _SkeletonShimmer extends StatefulWidget {
  const _SkeletonShimmer();

  @override
  State<_SkeletonShimmer> createState() => _SkeletonShimmerState();
}

class _SkeletonShimmerState extends State<_SkeletonShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final shimmerPosition = _controller.value * 2 - 1;
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1 + shimmerPosition, -0.3),
              end: Alignment(1 + shimmerPosition, 0.3),
              colors: [
                Colors.white.withOpacity(0.06),
                Colors.white.withOpacity(0.16),
                Colors.white.withOpacity(0.06),
              ],
            ),
          ),
        );
      },
    );
  }
}
