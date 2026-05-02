import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haggle/app/routes/app_pages.dart';

import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/auth_divider_label.dart';
import '../../../widgets/auth_option_button.dart';
import '../../../widgets/auth_scaffold.dart';
import '../../../widgets/auth_tab_row.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AuthScaffold(
      title: 'Log in',
      subtitle:
          'Pick up your live deals, seller reminders, and active negotiations without losing momentum.',
      heroLabel: 'Marketplace access with context intact',
      heroHighlights: const [
        'Return to saved deals and reserved live tickets',
        'Stay close to sellers you already follow',
        'Jump into active buyer conversations faster',
      ],
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'New to Haggle?',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.dark.withOpacity(0.7),
            ),
          ),
          TextButton(
            onPressed: () => Get.toNamed(Routes.SIGNUP),
            child: const Text('Create account'),
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
              'Welcome back',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Use your preferred login method to continue.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.dark.withOpacity(0.66),
              ),
            ),
            const SizedBox(height: 18),
            const AuthTabRow(),
            const SizedBox(height: 18),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone or email',
                hintText: 'you@haggle.app',
                filled: true,
                fillColor: const Color(0xFFF9F6F1),
                prefixIcon: const Icon(Icons.person_outline_rounded),
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
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                child: const Text('Forgot password?'),
              ),
            ),
            const SizedBox(height: 10),
            AuthOptionButton(
              label: 'Log in',
              icon: Icons.lock_open_outlined,
              isPrimary: true,
              onPressed: () {
                Get.toNamed(Routes.LOGIN);
              },
            ),
            const SizedBox(height: 18),
            const AuthDividerLabel(text: 'or continue with'),
            const SizedBox(height: 16),
            AuthOptionButton(
              label: 'Continue with Google',
              icon: Icons.g_mobiledata,
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            AuthOptionButton(
              label: 'Continue with Apple',
              icon: Icons.apple,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
