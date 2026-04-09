import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class DashboardBottomNav extends StatelessWidget {
  const DashboardBottomNav({super.key, required this.currentIndex, required this.onTap});

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
                  DashboardNavItem(
                    label: 'Home',
                    icon: Icons.home_outlined,
                    isActive: currentIndex == 0,
                    onTap: () => onTap(0),
                  ),
                  DashboardNavItem(
                    label: 'Market',
                    icon: Icons.storefront_outlined,
                    isActive: currentIndex == 1,
                    onTap: () => onTap(1),
                  ),
                  const SizedBox(width: 54),
                  DashboardNavItem(
                    label: 'Message',
                    icon: Icons.chat_bubble_outline,
                    isActive: currentIndex == 3,
                    onTap: () => onTap(3),
                  ),
                  DashboardNavItem(
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

class DashboardNavItem extends StatelessWidget {
  const DashboardNavItem({
    super.key,
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
