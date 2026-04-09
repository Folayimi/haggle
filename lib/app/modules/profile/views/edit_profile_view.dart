import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/mock_seller_profiles.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/haggle_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _businessController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final seller = Get.arguments as SellerProfileData?;
    _nameController = TextEditingController(text: seller?.name ?? '');
    _usernameController = TextEditingController(text: seller?.username ?? '');
    _businessController = TextEditingController(text: seller?.businessName ?? '');
    _bioController = TextEditingController(text: seller?.bio ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _businessController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        title: const Text('Edit profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FormSection(
              title: 'Profile details',
              child: Column(
                children: [
                  _Field(label: 'Full name', controller: _nameController),
                  const SizedBox(height: 12),
                  _Field(label: 'Username', controller: _usernameController),
                  const SizedBox(height: 12),
                  _Field(label: 'Business name', controller: _businessController),
                  const SizedBox(height: 12),
                  _Field(
                    label: 'Bio',
                    controller: _bioController,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _FormSection(
              title: 'Visibility',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Public profile settings',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.dark,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Changes here affect how buyers discover you and your listings.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.dark.withOpacity(0.65),
                        ),
                  ),
                  const SizedBox(height: 12),
                  _ToggleRow(
                    title: 'Show contact availability',
                    subtitle: 'Let buyers know you accept direct chats.',
                    value: true,
                    onChanged: (_) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            HaggleButton(
              label: 'Save changes',
              icon: Icons.check_circle_outline,
              onPressed: () {
                Get.snackbar(
                  'Profile updated',
                  'Your profile edits have been saved.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.white,
                  colorText: AppColors.dark,
                  margin: const EdgeInsets.all(16),
                );
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.controller,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppColors.lightBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.neutral),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.neutral),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.dark.withOpacity(0.6),
                      ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
