import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/haggle_button.dart';
import '../../../widgets/haggle_card.dart';

class PostProductView extends StatelessWidget {
  const PostProductView({super.key});

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
              _CreateHeader(
                title: 'Post Product',
                subtitle: 'Publish a polished product listing buyers can trust quickly.',
              ),
              const SizedBox(height: 18),
              _LeadPanel(
                title: 'Product setup',
                description:
                    'Bring together your best image, pricing, condition, and the main reason a buyer should stop scrolling.',
                metrics: const ['Images first', 'Price clarity', 'Live-ready'],
              ),
              const SizedBox(height: 18),
              const _FormCard(
                title: 'Core details',
                fields: [
                  'Product name',
                  'Category',
                  'Price range',
                  'Condition or stock status',
                ],
              ),
              const SizedBox(height: 14),
              const _FormCard(
                title: 'Buyer-facing story',
                fields: [
                  'Short product description',
                  'Top features',
                  'Bundle or negotiation note',
                  'Cover image and gallery',
                ],
              ),
              const SizedBox(height: 18),
              const HaggleButton(
                label: 'Continue product draft',
                icon: Icons.arrow_forward_rounded,
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateHeader extends StatelessWidget {
  const _CreateHeader({
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
        _TopActionButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: Get.back,
        ),
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

class _LeadPanel extends StatelessWidget {
  const _LeadPanel({
    required this.title,
    required this.description,
    required this.metrics,
  });

  final String title;
  final String description;
  final List<String> metrics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF231F20),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.74),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: metrics
                .map(
                  (metric) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      metric,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
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

class _FormCard extends StatelessWidget {
  const _FormCard({
    required this.title,
    required this.fields,
  });

  final String title;
  final List<String> fields;

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
          ...fields.map(
            (field) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: field,
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
