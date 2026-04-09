import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/haggle_button.dart';
import '../../../widgets/haggle_card.dart';

class ScheduleLiveView extends StatelessWidget {
  const ScheduleLiveView({super.key});

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
              const _LiveHeader(),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1E9),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Plan a room buyers want to enter',
                      style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Set the schedule, explain what will be shown live, and give buyers a reason to reserve a reminder.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.dark.withOpacity(0.7),
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: const [
                        _PillLabel(text: 'Date and time'),
                        _PillLabel(text: 'Room title'),
                        _PillLabel(text: 'Buyer benefit'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const _LiveSectionCard(
                title: 'Session setup',
                fields: [
                  'Live title',
                  'Date',
                  'Time',
                  'Expected duration',
                ],
              ),
              const SizedBox(height: 14),
              const _LiveSectionCard(
                title: 'What will happen in the room',
                fields: [
                  'Product or service focus',
                  'What buyers will see explained live',
                  'Special offer or negotiation angle',
                  'Reminder message',
                ],
              ),
              const SizedBox(height: 18),
              const HaggleButton(
                label: 'Save live schedule',
                icon: Icons.event_available_rounded,
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiveHeader extends StatelessWidget {
  const _LiveHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        _BackButtonChip(onTap: Get.back),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Schedule Live',
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 2),
              Text(
                'Set up your next live negotiation or service explanation room.',
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

class _PillLabel extends StatelessWidget {
  const _PillLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _LiveSectionCard extends StatelessWidget {
  const _LiveSectionCard({
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

class _BackButtonChip extends StatelessWidget {
  const _BackButtonChip({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: const SizedBox(
          width: 42,
          height: 42,
          child: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.dark),
        ),
      ),
    );
  }
}
