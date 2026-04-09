import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/circle_icon_button.dart';
import '../../../../widgets/haggle_button.dart';
import '../../../../widgets/haggle_card.dart';
import '../../../../widgets/section_header.dart';

class CreateTab extends StatelessWidget {
  const CreateTab({super.key, required this.onMenuTap});

  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleIconButton(icon: Icons.menu_rounded, onTap: onMenuTap),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create',
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Build your next product drop or live room',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: AppColors.dark.withOpacity(0.62),
                    ),
                  ),
                ],
              ),
            ),
            const CircleIconButton(icon: Icons.notifications_none_rounded),
          ],
        ),
        const SizedBox(height: 20),
        _StudioHeroCard(
          theme: theme,
          onPostProduct: () => Get.toNamed(Routes.POST_PRODUCT),
          onScheduleLive: () => Get.toNamed(Routes.SCHEDULE_LIVE),
        ),
        const SizedBox(height: 22),
        const SectionHeader(title: 'Start Here'),
        const SizedBox(height: 12),
        _CreateEntryGrid(
          onPostProduct: () => Get.toNamed(Routes.POST_PRODUCT),
          onAddService: () => Get.toNamed(Routes.ADD_SERVICE),
          onScheduleLive: () => Get.toNamed(Routes.SCHEDULE_LIVE),
          onRoomStyling: () => Get.toNamed(Routes.ROOM_STYLING),
        ),
        const SizedBox(height: 24),
        const SectionHeader(title: 'Listing Workflow'),
        const SizedBox(height: 12),
        const _WorkflowCard(),
        const SizedBox(height: 24),
        const SectionHeader(title: 'Schedule A Live'),
        const SizedBox(height: 12),
        _LiveSetupCard(
          onScheduleLive: () => Get.toNamed(Routes.SCHEDULE_LIVE),
        ),
        const SizedBox(height: 24),
        const SectionHeader(title: 'Room Atmosphere'),
        const SizedBox(height: 12),
        const SizedBox(
          height: 188,
          child: _AtmosphereScroller(),
        ),
        const SizedBox(height: 24),
        const SectionHeader(title: 'What Buyers Will See'),
        const SizedBox(height: 12),
        const _RoomPreviewCard(),
      ],
    );
  }
}

class _StudioHeroCard extends StatelessWidget {
  const _StudioHeroCard({
    required this.theme,
    required this.onPostProduct,
    required this.onScheduleLive,
  });

  final ThemeData theme;
  final VoidCallback onPostProduct;
  final VoidCallback onScheduleLive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF231F20),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Text(
              'Seller studio',
              style: theme.textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Launch products, line up services, and shape the mood of every live room.',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              height: 1.25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Everything important is grouped here so sellers and service providers can publish faster and still look polished.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.76),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _HeroMetric(
                label: 'Ready to post',
                value: '12 drafts',
              ),
              _HeroMetric(
                label: 'Lives this week',
                value: '4 sessions',
              ),
              _HeroMetric(
                label: 'Buyer alerts',
                value: '1.2k reach',
              ),
            ],
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 430;
              final buttonWidth = isCompact ? constraints.maxWidth : (constraints.maxWidth - 12) / 2;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: buttonWidth,
                    child: HaggleButton(
                      label: 'Post a product',
                      icon: Icons.add_box_outlined,
                      onPressed: onPostProduct,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: buttonWidth,
                    child: HaggleButton(
                      label: 'Schedule live',
                      icon: Icons.videocam_outlined,
                      onPressed: onScheduleLive,
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.dark,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  const _HeroMetric({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 112,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.white.withOpacity(0.66),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateEntryGrid extends StatelessWidget {
  const _CreateEntryGrid({
    required this.onPostProduct,
    required this.onAddService,
    required this.onScheduleLive,
    required this.onRoomStyling,
  });

  final VoidCallback onPostProduct;
  final VoidCallback onAddService;
  final VoidCallback onScheduleLive;
  final VoidCallback onRoomStyling;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 560;
        final cardWidth = isCompact ? constraints.maxWidth : (constraints.maxWidth - 12) / 2;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: cardWidth,
              child: _EntryCard(
                icon: Icons.inventory_2_outlined,
                title: 'Products',
                subtitle: 'Add images, pricing, stock, and buyer-facing details.',
                onTap: onPostProduct,
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _EntryCard(
                icon: Icons.design_services_outlined,
                title: 'Services',
                subtitle: 'Package your service offer with timing, scope, and add-ons.',
                onTap: onAddService,
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _EntryCard(
                icon: Icons.videocam_outlined,
                title: 'Live sessions',
                subtitle: 'Create a room and tell buyers what will be shown live.',
                onTap: onScheduleLive,
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _EntryCard(
                icon: Icons.photo_library_outlined,
                title: 'Room styling',
                subtitle: 'Prepare cover images, previews, and room atmosphere before going live.',
                onTap: onRoomStyling,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.neutral),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: AppColors.primary),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_outward_rounded,
                    color: AppColors.dark.withOpacity(0.55),
                    size: 18,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.dark.withOpacity(0.66),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkflowCard extends StatelessWidget {
  const _WorkflowCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return HaggleCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Make your listing easy to trust',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            'Strong listings move faster when the basics are clean, visual, and direct.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.dark.withOpacity(0.66),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          const _WorkflowStep(
            number: '01',
            title: 'Add the cover image',
            subtitle: 'Lead with the strongest image so buyers understand the item at a glance.',
          ),
          const SizedBox(height: 14),
          const _WorkflowStep(
            number: '02',
            title: 'Write key details',
            subtitle: 'State the product type, condition, features, and why it stands out.',
          ),
          const SizedBox(height: 14),
          const _WorkflowStep(
            number: '03',
            title: 'Set the live angle',
            subtitle: 'Tell buyers what you will demonstrate, explain, or negotiate during the session.',
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 520;
              final tileWidth = isCompact ? constraints.maxWidth : (constraints.maxWidth - 12) / 2;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: tileWidth,
                    child: const _SoftMetaTile(
                      label: 'Best for',
                      value: 'Products and services',
                    ),
                  ),
                  SizedBox(
                    width: tileWidth,
                    child: const _SoftMetaTile(
                      label: 'Ideal format',
                      value: 'Images + live preview',
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _WorkflowStep extends StatelessWidget {
  const _WorkflowStep({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  final String number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: theme.textTheme.labelLarge?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.dark.withOpacity(0.66),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SoftMetaTile extends StatelessWidget {
  const _SoftMetaTile({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppColors.dark.withOpacity(0.56),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _LiveSetupCard extends StatelessWidget {
  const _LiveSetupCard({required this.onScheduleLive});

  final VoidCallback onScheduleLive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7F2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Live session planner',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Prime time',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Schedule the room, describe what will be shown, and let buyers know why they should join live.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.dark.withOpacity(0.66),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 520;
              final tileWidth = isCompact ? constraints.maxWidth : (constraints.maxWidth - 12) / 2;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: tileWidth,
                    child: const _SoftMetaTile(
                      label: 'Suggested slot',
                      value: 'Thu, 7:30 PM',
                    ),
                  ),
                  SizedBox(
                    width: tileWidth,
                    child: const _SoftMetaTile(
                      label: 'Room length',
                      value: '35 minutes',
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 520;
              final tileWidth = isCompact ? constraints.maxWidth : (constraints.maxWidth - 12) / 2;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: tileWidth,
                    child: const _SoftMetaTile(
                      label: 'Feature',
                      value: 'Product demo',
                    ),
                  ),
                  SizedBox(
                    width: tileWidth,
                    child: const _SoftMetaTile(
                      label: 'Buyer alert',
                      value: 'Auto reminder on',
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          HaggleButton(
            label: 'Plan a live session',
            icon: Icons.event_available_rounded,
            onPressed: onScheduleLive,
          ),
        ],
      ),
    );
  }
}

class _AtmosphereScroller extends StatelessWidget {
  const _AtmosphereScroller();

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: const [
        _AtmosphereCard(
          title: 'Boutique calm',
          subtitle: 'Soft and premium',
          detail: 'Best for decor, beauty, handmade goods, and elevated service sessions.',
          color: Color(0xFFEEE4D7),
          icon: Icons.chair_alt_outlined,
        ),
        SizedBox(width: 12),
        _AtmosphereCard(
          title: 'Studio focus',
          subtitle: 'Clean and direct',
          detail: 'Ideal when buyers need details, angles, demonstrations, and price clarity.',
          color: Color(0xFFE7ECEC),
          icon: Icons.light_mode_outlined,
        ),
        SizedBox(width: 12),
        _AtmosphereCard(
          title: 'Warm social',
          subtitle: 'Lively and human',
          detail: 'Great for haggles, launches, bundled offers, and room energy that feels active.',
          color: Color(0xFFFFE7DA),
          icon: Icons.groups_2_outlined,
        ),
      ],
    );
  }
}

class _AtmosphereCard extends StatelessWidget {
  const _AtmosphereCard({
    required this.title,
    required this.subtitle,
    required this.detail,
    required this.color,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final String detail;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 224,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.72),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.dark),
          ),
          const Spacer(),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: theme.textTheme.labelLarge?.copyWith(
              color: AppColors.dark.withOpacity(0.68),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            detail,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.dark.withOpacity(0.7),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomPreviewCard extends StatelessWidget {
  const _RoomPreviewCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return HaggleCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Preview your room story',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Buyer view',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'This is the kind of information buyers should pick up within seconds of entering your room.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.dark.withOpacity(0.66),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          const _PreviewRow(
            title: 'Cover image and product angle',
            subtitle: 'Lead with what is being sold or explained live.',
          ),
          const SizedBox(height: 12),
          const _PreviewRow(
            title: 'Short details and offer value',
            subtitle: 'Keep the hook clear: condition, benefit, discount, or bundle advantage.',
          ),
          const SizedBox(height: 12),
          const _PreviewRow(
            title: 'Atmosphere and live timing',
            subtitle: 'The room should feel intentional before the seller even starts talking.',
          ),
        ],
      ),
    );
  }
}

class _PreviewRow extends StatelessWidget {
  const _PreviewRow({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 3),
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.dark.withOpacity(0.66),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
