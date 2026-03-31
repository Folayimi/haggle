import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/auth_option_button.dart';
import '../../../widgets/auth_scaffold.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AuthScaffold(
      title: 'Reset password',
      subtitle: 'Send a secure reset link to recover your Haggle ID.',
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
              'Forgot password',
              style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Phone or email',
                hintText: 'you@haggle.app',
              ),
            ),
            const SizedBox(height: 16),
            AuthOptionButton(
              label: 'Send reset link',
              icon: Icons.mark_email_unread_outlined,
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            Text(
              'If your account uses phone login, we will send an OTP instead.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
      bottom: TextButton(
        onPressed: () => Get.toNamed(Routes.LOGIN),
        child: const Text('Back to sign in'),
      ),
    );
  }
}
