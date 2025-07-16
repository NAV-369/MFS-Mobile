import 'package:flutter/material.dart';
import 'package:mfs_mobile/core/theme/app_colors_extension.dart';

class AppCard extends StatelessWidget {
  final Widget? child;
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final List<Widget>? actions;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final double elevation;
  final double borderRadius;
  final Color? color;
  final Color? shadowColor;
  final bool borderOnForeground;
  final bool semanticContainer;
  final Clip clipBehavior;
  final ShapeBorder? shape;
  final bool showBorder;
  final Color? borderColor;
  final double borderWidth;
  final Gradient? gradient;
  final bool showShadow;
  final List<BoxShadow>? customShadow;
  final BorderRadius? customBorderRadius;

  const AppCard({
    super.key,
    this.child,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.actions,
    this.onTap,
    this.onLongPress,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.elevation = 0.5,
    this.borderRadius = 12.0,
    this.color,
    this.shadowColor,
    this.borderOnForeground = true,
    this.semanticContainer = true,
    this.clipBehavior = Clip.none,
    this.shape,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth = 1.0,
    this.gradient,
    this.showShadow = true,
    this.customShadow,
    this.customBorderRadius,
  })  : assert(elevation >= 0.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColorsExtension>()!;
    final effectiveBorderRadius = customBorderRadius ?? BorderRadius.circular(borderRadius);
    final effectiveColor = color ?? colors.cardBackground;
    final effectiveBorderColor = borderColor ?? colors.border;
    final effectiveShadowColor = shadowColor ?? colors.shadow.withOpacity(0.1);

    Widget card = Container(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: gradient != null ? null : effectiveColor,
        gradient: gradient,
        borderRadius: effectiveBorderRadius,
        border: showBorder
            ? Border.all(
                color: effectiveBorderColor,
                width: borderWidth,
              )
            : null,
        boxShadow: showShadow
            ? customShadow ??
                [
                  BoxShadow(
                    color: effectiveShadowColor,
                    blurRadius: elevation * 2,
                    offset: const Offset(0, 2),
                  ),
                ]
            : null,
      ),
      child: Material(
        type: effectiveColor == Colors.transparent
            ? MaterialType.transparency
            : MaterialType.card,
        color: Colors.transparent,
        borderRadius: effectiveBorderRadius,
        clipBehavior: clipBehavior,
        child: _buildContent(context, colors),
      ),
    );

    // Wrap with InkWell if onTap or onLongPress is provided
    if (onTap != null || onLongPress != null) {
      card = InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: effectiveBorderRadius,
        child: card,
      );
    }

    return card;
  }

  Widget _buildContent(BuildContext context, AppColorsExtension colors) {
    // If child is provided, use it directly
    if (child != null) {
      return Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: child,
      );
    }

    // Otherwise, build from title, subtitle, etc.
    final List<Widget> children = [];

    // Add header row if title, leading or trailing is provided
    if (title != null || leading != null || trailing != null) {
      children.add(
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, subtitle != null ? 4.0 : 16.0),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 12.0),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ) ??
                          const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                      child: title ?? const SizedBox.shrink(),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2.0),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: colors.textSecondary,
                                ) ??
                                const TextStyle(fontSize: 12.0),
                        child: subtitle!,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 8.0),
                trailing!,
              ],
            ],
          ),
        ),
      );
    }

    // Add actions if provided
    if (actions != null && actions!.isNotEmpty) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: OverflowBar(
            alignment: MainAxisAlignment.end,
            children: actions!,
          ),
        ),
      );
    }

    // If no content is provided, return an empty container
    if (children.isEmpty) {
      return Container();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  // Factory constructor for a simple card with title and content
  factory AppCard.simple({
    Key? key,
    required String title,
    required Widget content,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
  }) {
    return AppCard(
      key: key,
      title: Text(title),
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      padding: padding,
      width: width,
      height: height,
      child: content,
    );
  }

  // Factory constructor for a card with a list tile
  factory AppCard.listTile({
    Key? key,
    required String title,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
    bool dense = false,
    bool isThreeLine = false,
    bool enabled = true,
  }) {
    return AppCard(
      key: key,
      margin: EdgeInsets.zero,
      elevation: 0,
      showBorder: true,
      borderWidth: 0.5,
      borderRadius: 0,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: dense ? 8.0 : 12.0,
        ),
        leading: leading,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: enabled ? null : Colors.grey[500],
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(
                  color: enabled ? Colors.grey[600] : Colors.grey[400],
                ),
              )
            : null,
        trailing: trailing,
        onTap: enabled ? onTap : null,
        enabled: enabled,
        isThreeLine: isThreeLine,
        dense: dense,
      ),
    );
  }

  // Factory constructor for a card with a grid view
  factory AppCard.grid({
    Key? key,
    required List<Widget> children,
    int crossAxisCount = 2,
    double childAspectRatio = 1.0,
    double mainAxisSpacing = 8.0,
    double crossAxisSpacing = 8.0,
    EdgeInsetsGeometry? padding,
    bool shrinkWrap = false,
    ScrollPhysics? physics,
  }) {
    return AppCard(
      key: key,
      padding: padding ?? const EdgeInsets.all(16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.count(
            shrinkWrap: shrinkWrap,
            physics: physics,
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            children: children,
          );
        },
      ),
    );
  }
}
