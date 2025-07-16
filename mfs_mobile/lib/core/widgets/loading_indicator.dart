import 'package:flutter/material.dart';
import 'package:mfs_mobile/core/theme/app_colors_extension.dart';

class AppLoadingIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;
  final bool center;

  const AppLoadingIndicator({
    super.key,
    this.size = 24.0,
    this.strokeWidth = 2.5,
    this.color,
    this.center = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColorsExtension>()!;
    final color = this.color ?? colors.primary;

    final indicator = SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: strokeWidth,
      ),
    );

    if (!center) return indicator;

    return Center(
      child: indicator,
    );
  }

  static Widget small({Color? color}) {
    return AppLoadingIndicator(
      size: 20.0,
      strokeWidth: 2.0,
      color: color,
    );
  }

  static Widget medium({Color? color}) {
    return AppLoadingIndicator(
      size: 28.0,
      strokeWidth: 3.0,
      color: color,
    );
  }

  static Widget large({Color? color}) {
    return AppLoadingIndicator(
      size: 36.0,
      strokeWidth: 3.5,
      color: color,
    );
  }
}
