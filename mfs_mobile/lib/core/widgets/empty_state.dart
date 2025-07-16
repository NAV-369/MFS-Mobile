import 'package:flutter/material.dart';
import 'package:mfs_mobile/core/theme/app_colors_extension.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String? message;
  final String? buttonText;
  final VoidCallback? onActionPressed;
  final IconData? icon;
  final double iconSize;
  final double spacing;
  final bool showIcon;

  const EmptyState({
    super.key,
    required this.title,
    this.message,
    this.buttonText,
    this.onActionPressed,
    this.icon,
    this.iconSize = 64.0,
    this.spacing = 16.0,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColorsExtension>()!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIcon)
              Icon(
                icon ?? Icons.inbox_rounded,
                size: iconSize,
                color: colors.textTertiary,
              ),
            if (showIcon) SizedBox(height: spacing),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (message != null) SizedBox(height: spacing / 2),
            if (message != null)
              Text(
                message!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            if (onActionPressed != null) SizedBox(height: spacing),
            if (onActionPressed != null)
              ElevatedButton(
                onPressed: onActionPressed,
                child: Text(buttonText ?? 'Try Again'),
              ),
          ],
        ),
      ),
    );
  }

  factory EmptyState.withAction({
    Key? key,
    required String title,
    String? message,
    required String buttonText,
    required VoidCallback onActionPressed,
    IconData? icon,
  }) {
    return EmptyState(
      key: key,
      title: title,
      message: message,
      buttonText: buttonText,
      onActionPressed: onActionPressed,
      icon: icon,
    );
  }

  factory EmptyState.simple({
    Key? key,
    required String title,
    String? message,
    IconData? icon,
  }) {
    return EmptyState(
      key: key,
      title: title,
      message: message,
      icon: icon,
      showIcon: icon != null,
    );
  }
}
