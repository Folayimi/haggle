import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/theme_controller.dart';
import '../routes/app_pages.dart';
import '../theme/app_colors.dart';
import '../modules/dashboard/views/analytics_page.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key, required this.themeController});

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
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AnalyticsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_border),
            title: const Text('Saved Deals'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.confirmation_num_outlined),
            title: const Text('Reminders'),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(Routes.REMINDERS);
            },
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
