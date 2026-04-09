import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AuthTabRow extends StatelessWidget {
  const AuthTabRow({super.key, this.activeLabel = 'Phone'});

  final String activeLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F3EE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: AuthTab(label: 'Phone', isActive: activeLabel == 'Phone'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: AuthTab(label: 'Email', isActive: activeLabel == 'Email'),
          ),
        ],
      ),
    );
  }
}

class AuthTab extends StatelessWidget {
  const AuthTab({super.key, required this.label, this.isActive = false});

  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? AppColors.neutral : Colors.transparent,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: theme.textTheme.labelLarge?.copyWith(
          color: isActive ? AppColors.dark : AppColors.dark.withOpacity(0.5),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
