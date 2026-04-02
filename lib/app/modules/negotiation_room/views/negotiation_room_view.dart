import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/haggle_button.dart';
import '../../../widgets/haggle_card.dart';
import '../../../widgets/meeting_control_button.dart';
import '../../../widgets/meeting_participant_grid.dart';
import '../../../widgets/meeting_video_tile.dart';
import '../../../widgets/offer_stepper.dart';
import '../../../widgets/price_tag.dart';
import '../../../widgets/timer_pill.dart';
import '../../../widgets/meeting_voice_only_stage.dart';
import '../controllers/negotiation_room_controller.dart';

class NegotiationRoomView extends GetView<NegotiationRoomController> {
  const NegotiationRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Negotiation Room',
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  const TimerPill(label: '02:18 left'),
                  const SizedBox(width: 8),
                  Obx(
                    () => MeetingControlButton(
                      icon: controller.isGridView.value ? Icons.grid_view : Icons.view_agenda_outlined,
                      label: controller.isGridView.value ? 'Grid' : 'Focus',
                      isActive: controller.isGridView.value,
                      onTap: controller.toggleGrid,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Live',
                      style: theme.textTheme.labelSmall?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => Stack(
                  children: [
                    Positioned.fill(
                      child: controller.isVoiceOnly.value
                          ? const MeetingVoiceOnlyStage()
                              : controller.isGridView.value
                                  ? const MeetingParticipantGrid()
                                  : MeetingVideoTile(
                                      imageUrl:
                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Portrait_of_a_woman_%28Unsplash%29.jpg/960px-Portrait_of_a_woman_%28Unsplash%29.jpg',
                                      name: 'Seller Live',
                                      isMuted: false,
                                      showAudioWave: true,
                                    ),
                    ),
                    if (!controller.isVoiceOnly.value)
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: SizedBox(
                          height: 140,
                          width: 100,
                          child: MeetingVideoTile(
                            imageUrl:
                                'https://upload.wikimedia.org/wikipedia/commons/7/74/Portrait_%28Unsplash%29.jpg',
                            name: 'You',
                            isSelf: true,
                            isMuted: controller.isMuted.value,
                            borderRadius: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
              decoration: BoxDecoration(
                color: AppColors.dark,
                border: Border(top: BorderSide(color: Colors.white.withOpacity(0.08))),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: HaggleCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Offer',
                                style: theme.textTheme.labelMedium?.copyWith(color: Colors.white70),
                              ),
                              const SizedBox(height: 8),
                              Obx(
                                () => PriceTag(
                                  amount: controller.currentOffer.value.toString(),
                                  isEmphasis: true,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Obx(
                                () => OfferStepper(
                                  offer: controller.currentOffer.value,
                                  onIncrease: controller.increaseOffer,
                                  onDecrease: controller.decreaseOffer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: HaggleCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Seller',
                                style: theme.textTheme.labelMedium?.copyWith(color: Colors.white70),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Nathan Rusl',
                                style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Ready for voice',
                                style: theme.textTheme.labelSmall?.copyWith(color: AppColors.success),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Obx(
                        () => MeetingControlButton(
                          icon: controller.isMuted.value ? Icons.mic_off : Icons.mic,
                          label: controller.isMuted.value ? 'Muted' : 'Mic',
                          isActive: !controller.isMuted.value,
                          onTap: controller.toggleMute,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Obx(
                        () => MeetingControlButton(
                          icon: controller.isVideoEnabled.value ? Icons.videocam : Icons.videocam_off,
                          label: controller.isVideoEnabled.value ? 'Camera' : 'Camera off',
                          isActive: controller.isVideoEnabled.value,
                          onTap: controller.toggleVideo,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Obx(
                        () => MeetingControlButton(
                          icon: Icons.pan_tool_outlined,
                          label: controller.isHandRaised.value ? 'Raised' : 'Raise hand',
                          isActive: controller.isHandRaised.value,
                          onTap: controller.toggleHand,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Obx(
                        () => MeetingControlButton(
                          icon: Icons.headset_mic_outlined,
                          label: controller.isVoiceOnly.value ? 'Voice only' : 'Switch to voice',
                          isActive: controller.isVoiceOnly.value,
                          onTap: controller.toggleVoiceOnly,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const HaggleButton(label: 'Send Offer', onPressed: null),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
