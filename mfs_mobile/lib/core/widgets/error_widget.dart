import 'package:flutter/material.dart';
import 'package:mfs_mobile/core/theme/app_colors_extension.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final String? buttonText;
  final VoidCallback? onRetry;
  final IconData? icon;
  final double spacing;
  final bool showIcon;

  const AppErrorWidget({
    super.key,
    required this.message,
    this.buttonText,
    this.onRetry,
    this.icon,
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
                icon ?? Icons.error_outline_rounded,
                size: 64,
                color: colors.error,
              ),
            if (showIcon) SizedBox(height: spacing),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colors.textSecondary,
              ),
            ),
            if (onRetry != null) SizedBox(height: spacing / 2),
            if (onRetry != null)
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.error,
                  foregroundColor: Colors.white,
                ),
                child: Text(buttonText ?? 'Retry'),
              ),
          ],
        ),
      ),
    );
  }

  factory AppErrorWidget.networkError({
    Key? key,
    VoidCallback? onRetry,
    String? message,
  }) {
    return AppErrorWidget(
      key: key,
      message: message ?? 'No internet connection. Please check your network settings and try again.',
      buttonText: 'Retry',
      onRetry: onRetry,
      icon: Icons.wifi_off_rounded,
    );
  }

  factory AppErrorWidget.somethingWentWrong({
    Key? key,
    VoidCallback? onRetry,
    String? message,
  }) {
    return AppErrorWidget(
      key: key,
      message: message ?? 'Something went wrong. Please try again later.',
      buttonText: 'Try Again',
      onRetry: onRetry,
      icon: Icons.error_outline_rounded,
    );
  }
}
