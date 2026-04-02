import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/theme_controller.dart';
import '../../../theme/app_colors.dart';
import '../controllers/dashboard_controller.dart';
import 'tabs/create_tab.dart';
import 'tabs/live_feed_tab.dart';
import 'tabs/message_tab.dart';
import 'tabs/negotiate_tab.dart';
import 'tabs/profile_tab.dart';
import 'tabs/search_tab.dart';
import 'analytics_page.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      drawer: _DashboardDrawer(themeController: themeController),
      body: Obx(() => _DashboardBody(index: controller.selectedIndex.value)),
      bottomNavigationBar: Obx(
        () => _BottomNavBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.setTab,
        ),
      ),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    void openDrawer() => Scaffold.of(context).openDrawer();

    final pages = [
      LiveFeedTab(onMenuTap: openDrawer),
      SearchTab(onMenuTap: openDrawer),
      CreateTab(onMenuTap: openDrawer),
      MessageTab(onMenuTap: openDrawer),
      ProfileTab(onMenuTap: openDrawer),
    ];

    final padding = index == 0 ? EdgeInsets.zero : const EdgeInsets.fromLTRB(16, 16, 16, 32);
    return SafeArea(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        child: SingleChildScrollView(
          key: ValueKey(index),
          padding: padding,
          child: pages[index],
        ),
      ),
    );
  }
}

class _DashboardDrawer extends StatelessWidget {
  const _DashboardDrawer({required this.themeController});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.secondary,
            ),
            child: Row(
              children: [
                const CircleAvatar(radius: 26, child: Icon(Icons.storefront_outlined)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Haggle Control',
                        style: theme.textTheme.titleMedium?.copyWith(color: AppColors.accent),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Marketplace HQ',
                        style: theme.textTheme.labelMedium?.copyWith(color: AppColors.neutral),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text('Vendor Dashboard'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart_outlined),
            title: const Text('Analytics'),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => const AnalyticsPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_border),
            title: const Text('Saved Deals'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.multitrack_audio_outlined),
            title: const Text('Room Atmospheres'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.verified_user_outlined),
            title: const Text('Trust and Safety'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () => Navigator.pop(context),
          ),
          const Spacer(),
          ListTile(
            leading: Icon(themeController.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            title: const Text('Toggle Theme'),
            onTap: themeController.toggleTheme,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: AppColors.neutral),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavItem(
                    label: 'Home',
                    icon: Icons.home_outlined,
                    isActive: currentIndex == 0,
                    onTap: () => onTap(0),
                  ),
                  _NavItem(
                    label: 'Search',
                    icon: Icons.search,
                    isActive: currentIndex == 1,
                    onTap: () => onTap(1),
                  ),
                  const SizedBox(width: 54),
                  _NavItem(
                    label: 'Message',
                    icon: Icons.chat_bubble_outline,
                    isActive: currentIndex == 3,
                    onTap: () => onTap(3),
                  ),
                  _NavItem(
                    label: 'Profile',
                    icon: Icons.person_outline,
                    isActive: currentIndex == 4,
                    onTap: () => onTap(4),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -6,
            child: GestureDetector(
              onTap: () => onTap(2),
              child: Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.dark.withOpacity(0.6);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
