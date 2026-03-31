import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/theme_controller.dart';
import '../../../widgets/haggle_button.dart';
import '../../../widgets/haggle_card.dart';
import '../../../widgets/haggle_chip.dart';
import '../../../widgets/mic_button.dart';
import '../../../widgets/offer_stepper.dart';
import '../../../widgets/price_tag.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/session_card.dart';
import '../../../widgets/stat_tile.dart';
import '../../../widgets/timer_pill.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Haggle UI Kit'),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
              tooltip: 'Toggle theme',
              onPressed: themeController.toggleTheme,
              icon: Icon(
                themeController.themeMode == ThemeMode.dark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Live Sessions'),
          const SizedBox(height: 12),
          SessionCard(
            title: 'Vintage Camera Bundle',
            vendor: 'Fola Studios',
            thumbnail: Container(
              color: theme.colorScheme.primary.withOpacity(0.12),
              child: const Center(child: Icon(Icons.camera_alt_outlined, size: 40)),
            ),
            price: '45,000',
            timeLeft: '04:18',
            viewers: 18,
          ),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Quick Actions'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              HaggleChip(label: 'Trending', isSelected: true),
              HaggleChip(label: 'Ending Soon'),
              HaggleChip(label: 'Premier'),
              HaggleChip(label: 'Garage Sale'),
            ],
          ),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Auth Previews'),
          const SizedBox(height: 12),
          HaggleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jump into the auth flows',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                HaggleButton(
                  label: 'View Login',
                  onPressed: () => Get.toNamed(Routes.LOGIN),
                ),
                const SizedBox(height: 10),
                HaggleButton(
                  label: 'View Signup',
                  onPressed: () => Get.toNamed(Routes.SIGNUP),
                ),
                const SizedBox(height: 10),
                HaggleButton(
                  label: 'View Forgot Password',
                  onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          HaggleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'Make an Offer'),
                const SizedBox(height: 12),
                const PriceTag(amount: '32,000', isEmphasis: true),
                const SizedBox(height: 12),
                OfferStepper(
                  offer: 32000,
                  onIncrease: () {},
                  onDecrease: () {},
                ),
                const SizedBox(height: 14),
                const TimerPill(label: '02:00 left'),
                const SizedBox(height: 16),
                const HaggleButton(label: 'Send Offer', onPressed: null),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Voice Room'),
          const SizedBox(height: 12),
          Row(
            children: [
              MicButton(isActive: true, onPressed: () {}),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Live mic connection with vendor',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Seller Stats'),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(
                child: StatTile(label: 'Viewers', value: '128', icon: Icons.remove_red_eye_outlined),
              ),
              SizedBox(width: 12),
              Expanded(
                child: StatTile(label: 'Offers', value: '16', icon: Icons.local_offer_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
