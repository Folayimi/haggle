import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class HaggleButton extends StatelessWidget {
  const HaggleButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = onPressed == null || isLoading;
    final child = isLoading
        ? const SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          );

    final button = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: isDisabled
                ? theme.dividerColor.withOpacity(0.2)
                : (backgroundColor ?? AppColors.primary),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDisabled
                  ? theme.dividerColor.withOpacity(0.3)
                  : AppColors.accent.withOpacity(0.6),
            ),
            boxShadow: isDisabled
                ? []
                : [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.28),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: Container(
            constraints: const BoxConstraints(minHeight: 52),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            alignment: Alignment.center,
            child: IconTheme(
              data: IconThemeData(
                color: foregroundColor ?? AppColors.accent,
              ),
              child: DefaultTextStyle(
                style: theme.textTheme.labelLarge?.copyWith(
                      color: foregroundColor ?? AppColors.accent,
                    ) ??
                    const TextStyle(color: AppColors.accent),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );

    if (!isFullWidth) return button;

    return SizedBox(
      width: double.infinity,
      child: button,
    );
  }
}
