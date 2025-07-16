import 'package:flutter/material.dart';
import 'package:mfs_mobile/core/theme/app_colors_extension.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final Widget? leading;
  final double elevation;
  final Color? backgroundColor;
  final double? titleSpacing;
  final double? leadingWidth;
  final PreferredSizeWidget? bottom;
  final double? toolbarHeight;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final TextStyle? titleStyle;
  final double? titleSize;
  final FontWeight? titleWeight;
  final Color? titleColor;
  final bool showDivider;
  final Color? dividerColor;
  final double? dividerHeight;
  final double? dividerThickness;
  final EdgeInsetsGeometry? titlePadding;

  const AppAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.centerTitle = false,
    this.automaticallyImplyLeading = true,
    this.leading,
    this.elevation = 0,
    this.backgroundColor,
    this.titleSpacing,
    this.leadingWidth,
    this.bottom,
    this.toolbarHeight = kToolbarHeight,
    this.showBackButton = false,
    this.onBackPressed,
    this.titleStyle,
    this.titleSize,
    this.titleWeight = FontWeight.w600,
    this.titleColor,
    this.showDivider = false,
    this.dividerColor,
    this.dividerHeight = 1.0,
    this.dividerThickness = 0.5,
    this.titlePadding,
  })  : assert(title == null || titleWidget == null,
            'Cannot provide both a title and a titleWidget');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColorsExtension>()!;
    final textTheme = theme.textTheme;

    return AppBar(
      title: titleWidget ??
          (title != null
              ? Text(
                  title!,
                  style: titleStyle ??
                      textTheme.titleLarge?.copyWith(
                        color: titleColor ?? colors.textPrimary,
                        fontSize: titleSize,
                        fontWeight: titleWeight,
                      ),
                )
              : null),
      titleSpacing: titleSpacing,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading ??
          (showBackButton
              ? _buildBackButton(context, colors)
              : (automaticallyImplyLeading ? null : const SizedBox.shrink())),
      leadingWidth: leadingWidth,
      actions: actions,
      backgroundColor: backgroundColor ?? colors.cardBackground,
      elevation: elevation,
      bottom: showDivider
          ? PreferredSize(
              preferredSize: Size.fromHeight(dividerHeight ?? 1.0),
              child: Divider(
                height: dividerHeight,
                thickness: dividerThickness,
                color: dividerColor ?? colors.border,
              ),
            )
          : bottom,
      toolbarHeight: toolbarHeight,
      titleTextStyle: titleStyle,
      toolbarTextStyle: textTheme.bodyMedium,
      systemOverlayStyle: theme.appBarTheme.systemOverlayStyle,
    );
  }

  Widget _buildBackButton(BuildContext context, AppColorsExtension colors) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
      onPressed: onBackPressed ?? () => Navigator.maybePop(context),
      color: colors.textPrimary,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      toolbarHeight! + (bottom?.preferredSize.height ?? 0.0) + (showDivider ? dividerHeight! : 0.0));

  // Factory constructor for a simple app bar with title and back button
  factory AppAppBar.simple({
    Key? key,
    required String title,
    bool showBackButton = true,
    VoidCallback? onBackPressed,
    List<Widget>? actions,
    bool centerTitle = false,
    Color? backgroundColor,
    Color? titleColor,
    double? titleSize,
    FontWeight? titleWeight,
    bool showDivider = false,
  }) {
    return AppAppBar(
      key: key,
      title: title,
      showBackButton: showBackButton,
      onBackPressed: onBackPressed,
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      titleColor: titleColor,
      titleSize: titleSize,
      titleWeight: titleWeight,
      showDivider: showDivider,
    );
  }

  // Factory constructor for a transparent app bar
  factory AppAppBar.transparent({
    Key? key,
    String? title,
    Widget? titleWidget,
    bool showBackButton = true,
    VoidCallback? onBackPressed,
    List<Widget>? actions,
    bool centerTitle = false,
    Color? titleColor,
    double? titleSize,
    FontWeight? titleWeight,
  }) {
    return AppAppBar(
      key: key,
      title: title,
      titleWidget: titleWidget,
      showBackButton: showBackButton,
      onBackPressed: onBackPressed,
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleColor: titleColor,
      titleSize: titleSize,
      titleWeight: titleWeight,
    );
  }
}