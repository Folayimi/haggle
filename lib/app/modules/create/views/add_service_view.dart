import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/haggle_button.dart';
import '../../../widgets/haggle_card.dart';

class AddServiceView extends StatelessWidget {
  const AddServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FlowHeader(
                title: 'Add Service',
                subtitle: 'Shape a service offer that explains the value, process, and result clearly.',
              ),
              const SizedBox(height: 18),
              _TintedLeadCard(
                title: 'Service profile',
                description:
                    'Turn your service into something buyers can understand fast with scope, timing, and proof of value.',
                tone: const Color(0xFFE9F0EC),
                chips: const ['Scope', 'Availability', 'Expected outcome'],
              ),
              const SizedBox(height: 18),
              const _SimpleSectionCard(
                title: 'Service basics',
                items: [
                  'Service name',
                  'Category or expertise',
                  'Base price',
                  'Delivery time',
                ],
              ),
              const SizedBox(height: 14),
              const _SimpleSectionCard(
                title: 'Offer details',
                items: [
                  'What is included',
                  'Who the service is for',
                  'Add-ons or upgrade options',
                  'Portfolio image or preview',
                ],
              ),
              const SizedBox(height: 18),
              const HaggleButton(
                label: 'Save service draft',
                icon: Icons.design_services_outlined,
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlowHeader extends StatelessWidget {
  const _FlowHeader({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        _TopActionButton(icon: Icons.arrow_back_ios_new_rounded, onTap: Get.back),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppColors.dark.withOpacity(0.62),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TintedLeadCard extends StatelessWidget {
  const _TintedLeadCard({
    required this.title,
    required this.description,
    required this.tone,
    required this.chips,
  });

  final String title;
  final String description;
  final Color tone;
  final List<String> chips;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: tone,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.dark.withOpacity(0.72),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: chips
                .map(
                  (chip) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.84),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      chip,
                      style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _SimpleSectionCard extends StatelessWidget {
  const _SimpleSectionCard({
    required this.title,
    required this.items,
  });

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return HaggleCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: item,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.neutral),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopActionButton extends StatelessWidget {
  const _TopActionButton({
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, color: AppColors.dark),
        ),
      ),
    );
  }
}
