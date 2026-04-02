import 'package:flutter/material.dart';

class AuthDividerLabel extends StatelessWidget {
  const AuthDividerLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}
