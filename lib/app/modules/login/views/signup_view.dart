import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/auth_divider_label.dart';
import '../../../widgets/auth_option_button.dart';
import '../../../widgets/auth_scaffold.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AuthScaffold(
      title: 'Create account',
      subtitle: 'Set up your Haggle identity and move from discovery to live negotiation with less friction.',
      heroLabel: 'Built for buyers and sellers in motion',
      heroHighlights: const [
        'Track live reminders and reserved tickets easily',
        'Build a seller presence with products and scheduled sessions',
        'Keep messaging, haggling, and saved deals in one flow',
      ],
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.dark.withOpacity(0.7),
            ),
          ),
          TextButton(
            onPressed: () => Get.toNamed(Routes.LOGIN),
            child: const Text('Sign in'),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: AppColors.neutral),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Start your Haggle ID',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              'A few details and you are ready to browse, sell, and join live deals.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.dark.withOpacity(0.66),
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              decoration: InputDecoration(
                labelText: 'Full name',
                hintText: 'Ada Obinna',
                filled: true,
                fillColor: const Color(0xFFF9F6F1),
                prefixIcon: const Icon(Icons.badge_outlined),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: AppColors.neutral),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone or email',
                hintText: 'you@haggle.app',
                filled: true,
                fillColor: const Color(0xFFF9F6F1),
                prefixIcon: const Icon(Icons.alternate_email_rounded),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: AppColors.neutral),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: const Color(0xFFF9F6F1),
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: AppColors.neutral),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm password',
                filled: true,
                fillColor: const Color(0xFFF9F6F1),
                prefixIcon: const Icon(Icons.verified_user_outlined),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: AppColors.neutral),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 16),
            AuthOptionButton(
              label: 'Create account',
              icon: Icons.person_add_alt_1_outlined,
              isPrimary: true,
              onPressed: () {
                Get.toNamed(Routes.LOGIN);
              },
            ),
            const SizedBox(height: 12),
            Text(
              "By signing up, you agree to Haggle's marketplace rules and live negotiation guidelines.",
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.dark.withOpacity(0.6),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 18),
            const AuthDividerLabel(text: 'or sign up with'),
            const SizedBox(height: 14),
            AuthOptionButton(
              label: 'Continue with Google',
              icon: Icons.g_mobiledata,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
