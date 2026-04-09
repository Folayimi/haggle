import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/auth_option_button.dart';
import '../../../widgets/auth_scaffold.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AuthScaffold(
      title: 'Reset password',
      subtitle: 'Recover your Haggle access and get back to your saved deals, reminders, and live sessions.',
      heroLabel: 'Recovery built around continuity',
      heroHighlights: const [
        'Secure reset links for email accounts',
        'OTP fallback for phone-first sign in',
        'Fast return to your marketplace activity',
      ],
      bottom: TextButton(
        onPressed: () => Get.toNamed(Routes.LOGIN),
        child: const Text('Back to sign in'),
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
              'Recover your account',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              'We will send a secure reset link or OTP depending on your login method.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.dark.withOpacity(0.66),
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone or email',
                hintText: 'you@haggle.app',
                filled: true,
                fillColor: const Color(0xFFF9F6F1),
                prefixIcon: const Icon(Icons.mark_email_unread_outlined),
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
            const SizedBox(height: 18),
            AuthOptionButton(
              label: 'Send reset link',
              icon: Icons.send_rounded,
              isPrimary: true,
              onPressed: () {},
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F6F1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                'If your account uses phone login, we will send an OTP instead of an email link.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.dark.withOpacity(0.68),
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
