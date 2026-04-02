import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'audio_wave.dart';

class MeetingVoiceOnlyStage extends StatelessWidget {
  const MeetingVoiceOnlyStage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.dark,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AudioWave(),
          const SizedBox(height: 12),
          Text(
            'Voice only mode',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            'Video paused to keep the negotiation smooth.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
