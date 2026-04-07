import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/circle_icon_button.dart';
import '../../../../widgets/haggle_button.dart';
import '../../../../widgets/profile_widgets.dart';
import '../../../../widgets/profile_tab_sections.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key, required this.onMenuTap});

  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              const SizedBox(
                height: 70,
                width: double.infinity,
              ),
              Positioned(
                top: 16,
                left: 16,
                child: CircleIconButton(
                  icon: Icons.menu_rounded,
                  onTap: onMenuTap,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 14,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: CircleIconButton(
                  icon: Icons.settings_outlined,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 14,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.neutral),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: const [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          'https://upload.wikimedia.org/wikipedia/commons/7/74/Portrait_%28Unsplash%29.jpg',
                        ),
                      ),
                      EditBadge(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Ariyo Fola',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '@hagglefola | Active followers 2.4k',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.dark.withOpacity(0.6)),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      ProfileStatColumn(label: 'Past Haggles', value: '240'),
                      ProfileStatColumn(label: 'Items Posted', value: '58'),
                      ProfileStatColumn(label: 'Deals Won', value: '32'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Expanded(child: ProfileActionButton(label: 'Update profile')),
                      SizedBox(width: 12),
                      Expanded(child: ProfileActionButton(label: 'Message', isPrimary: false)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          const TabBar(
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.dark,
            tabs: [
              Tab(text: 'Negotiations'),
              Tab(text: 'Collections'),
              Tab(text: 'Saved'),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 520,
            child: TabBarView(
              children: [
                const NegotiationTabContent(),
                const CollectionsTabContent(),
                const SavedTabContent(),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text('Auth flows', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          HaggleButton(
            label: 'View login',
            onPressed: () => Get.toNamed(Routes.LOGIN),
          ),
          const SizedBox(height: 10),
          HaggleButton(
            label: 'View signup',
            onPressed: () => Get.toNamed(Routes.SIGNUP),
          ),
          const SizedBox(height: 10),
          HaggleButton(
            label: 'View forgot password',
            onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
          ),
        ],
      ),
    );
  }
}
