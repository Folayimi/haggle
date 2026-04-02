import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/haggle_button.dart';
import '../../../widgets/haggle_card.dart';
import '../../../widgets/mic_button.dart';
import '../../../widgets/offer_stepper.dart';
import '../../../widgets/price_tag.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/timer_pill.dart';
import '../controllers/negotiation_room_controller.dart';

class NegotiationRoomView extends GetView<NegotiationRoomController> {
  const NegotiationRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Get.back(),
        ),
        title: const Text('Negotiation Room'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Icon(Icons.storefront_outlined, color: AppColors.dark),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          HaggleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Live: Botanica Rose Lamp',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text('Seller: Nathan Rusl', style: theme.textTheme.labelMedium),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    TimerPill(label: '02:18 left'),
                    SizedBox(width: 10),
                    _RoomStatus(label: 'Voice ready'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: 'Voice Connection'),
          const SizedBox(height: 12),
          HaggleCard(
            child: Row(
              children: [
                Obx(
                  () => MicButton(
                    isActive: !controller.isMuted.value,
                    onPressed: controller.toggleMute,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Tap the mic to speak directly to the seller.',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                Obx(
                  () => _HandRaiseButton(
                    isRaised: controller.isHandRaised.value,
                    onTap: controller.toggleHand,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: 'Adjust Offer'),
          const SizedBox(height: 12),
          HaggleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => PriceTag(amount: controller.currentOffer.value.toString(), isEmphasis: true)),
                const SizedBox(height: 12),
                Obx(
                  () => OfferStepper(
                    offer: controller.currentOffer.value,
                    onIncrease: controller.increaseOffer,
                    onDecrease: controller.decreaseOffer,
                  ),
                ),
                const SizedBox(height: 14),
                const HaggleButton(label: 'Send Offer', onPressed: null),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: 'Room Notes'),
          const SizedBox(height: 12),
          HaggleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Seller tone: Calm and responsive', style: theme.textTheme.bodySmall),
                const SizedBox(height: 6),
                Text('Tip: Confident first offers get faster responses.', style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomStatus extends StatelessWidget {
  const _RoomStatus({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.success.withOpacity(0.6)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.success),
      ),
    );
  }
}

class _HandRaiseButton extends StatelessWidget {
  const _HandRaiseButton({required this.isRaised, required this.onTap});

  final bool isRaised;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isRaised ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.neutral),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.pan_tool_outlined, color: isRaised ? Colors.white : AppColors.dark, size: 18),
            const SizedBox(width: 6),
            Text(
              isRaised ? 'Hand raised' : 'Raise hand',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isRaised ? Colors.white : AppColors.dark,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
