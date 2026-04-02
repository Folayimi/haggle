import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
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
      subtitle: 'Continue with your Haggle ID or pick a quick sign-in.',
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'New to Haggle?',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          TextButton(
            onPressed: () => Get.toNamed(Routes.SIGNUP),
            child: const Text('Create account'),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.85),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: theme.dividerColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a login method',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            const AuthTabRow(),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Phone or email',
                hintText: 'you@haggle.app',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                child: const Text('Forgot password?'),
              ),
            ),
            const SizedBox(height: 12),
            AuthOptionButton(
              label: 'Log in',
              icon: Icons.lock_open_outlined,
              onPressed: () {},
            ),
            const SizedBox(height: 16),
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
