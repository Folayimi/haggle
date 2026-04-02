import 'package:flutter/material.dart';

class AuthTabRow extends StatelessWidget {
  const AuthTabRow({super.key, this.activeLabel = 'Phone'});

  final String activeLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AuthTab(label: 'Phone', isActive: activeLabel == 'Phone'),
        const SizedBox(width: 20),
        AuthTab(label: 'Email', isActive: activeLabel == 'Email'),
      ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: isActive
                ? theme.colorScheme.onSurface
                : theme.colorScheme.onSurface.withOpacity(0.5),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 2,
          width: 36,
          color: isActive ? theme.colorScheme.onSurface : Colors.transparent,
        ),
      ],
    );
  }
}
