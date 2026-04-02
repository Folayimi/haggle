import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'audio_wave.dart';

class MeetingVideoTile extends StatelessWidget {
  const MeetingVideoTile({
    super.key,
    required this.imageUrl,
    required this.name,
    this.isMuted = false,
    this.isSelf = false,
    this.borderRadius = 20,
    this.fit = BoxFit.cover,
    this.showAudioWave = false,
  });

  final String imageUrl;
  final String name;
  final bool isMuted;
  final bool isSelf;
  final double borderRadius;
  final BoxFit fit;
  final bool showAudioWave;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: fit,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.dark.withOpacity(0.18),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 10,
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isMuted) ...[
                      const Icon(Icons.mic_off, color: Colors.white, size: 12),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      isSelf ? 'You' : name,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white),
                    ),
                    if (showAudioWave && !isMuted) ...[
                      const SizedBox(width: 6),
                      const SizedBox(
                        height: 14,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: AudioWave(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
