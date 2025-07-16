import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  final Widget child;
  final String title;
  final String? subtitle;
  final List<Widget>? footer;
  final double elevation;
  final bool isLoading;

  const AuthCard({
    Key? key,
    required this.child,
    required this.title,
    this.subtitle,
    this.footer,
    this.elevation = 2,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.95 + (0.05 * value),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        margin: const EdgeInsets.all(16),
        child: Card(
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with logo and title
                Column(
                  children: [
                    // Logo placeholder - replace with your logo
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.account_balance_wallet,
                        size: 32,
                        color: theme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        subtitle!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.hintColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Form content
                if (isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  child,
                
                // Footer (e.g., sign up/sign in link)
                if (footer != null && footer!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  ...footer!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
