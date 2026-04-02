import 'package:flutter/material.dart';

import 'meeting_video_tile.dart';

class MeetingParticipantGrid extends StatelessWidget {
  const MeetingParticipantGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: const [
        MeetingVideoTile(
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Portrait_of_a_woman_%28Unsplash%29.jpg/640px-Portrait_of_a_woman_%28Unsplash%29.jpg',
          name: 'Seller',
          showAudioWave: true,
        ),
        MeetingVideoTile(
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/74/Portrait_%28Unsplash%29.jpg',
          name: 'You',
          isSelf: true,
        ),
        MeetingVideoTile(
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Portrait_of_a_man_%28Unsplash%29.jpg/640px-Portrait_of_a_man_%28Unsplash%29.jpg',
          name: 'Buyer A',
          isMuted: true,
        ),
        MeetingVideoTile(
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/71/Coffee_%28Unsplash%29.jpg',
          name: 'Observer',
          isMuted: true,
        ),
      ],
    );
  }
}
