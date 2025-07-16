import 'package:flutter/material.dart';

/// Custom theme colors that extend the Material color scheme
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  // Primary colors
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  
  // Secondary colors
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  
  // Background colors
  final Color background;
  final Color onBackground;
  
  // Surface colors
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  
  // Error colors
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  
  // Additional colors
  final Color shadow;
  final Color outline;
  final Color outlineVariant;
  
  // Text colors
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;
  
  // Background variants
  final Color backgroundVariant;
  final Color surfaceDisabled;
  
  // Other UI elements
  final Color divider;
  final Color border;
  final Color cardBackground;
  
  const AppColorsExtension({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.shadow,
    required this.outline,
    required this.outlineVariant,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.backgroundVariant,
    required this.surfaceDisabled,
    required this.divider,
    required this.border,
    required this.cardBackground,
  });

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? shadow,
    Color? outline,
    Color? outlineVariant,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textDisabled,
    Color? backgroundVariant,
    Color? surfaceDisabled,
    Color? divider,
    Color? border,
    Color? cardBackground,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      shadow: shadow ?? this.shadow,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textDisabled: textDisabled ?? this.textDisabled,
      backgroundVariant: backgroundVariant ?? this.backgroundVariant,
      surfaceDisabled: surfaceDisabled ?? this.surfaceDisabled,
      divider: divider ?? this.divider,
      border: border ?? this.border,
      cardBackground: cardBackground ?? this.cardBackground,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryContainer: Color.lerp(primaryContainer, other.primaryContainer, t)!,
      onPrimaryContainer: Color.lerp(onPrimaryContainer, other.onPrimaryContainer, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      secondaryContainer: Color.lerp(secondaryContainer, other.secondaryContainer, t)!,
      onSecondaryContainer: Color.lerp(onSecondaryContainer, other.onSecondaryContainer, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      onSurfaceVariant: Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t)!,
      onErrorContainer: Color.lerp(onErrorContainer, other.onErrorContainer, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      backgroundVariant: Color.lerp(backgroundVariant, other.backgroundVariant, t)!,
      surfaceDisabled: Color.lerp(surfaceDisabled, other.surfaceDisabled, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      border: Color.lerp(border, other.border, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
    );
  }

  // Light theme colors
  static const light = AppColorsExtension(
    primary: Color(0xFF006874),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF97F0FF),
    onPrimaryContainer: Color(0xFF001F24),
    secondary: Color(0xFF4A6267),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFCDE7EC),
    onSecondaryContainer: Color(0xFF051F23),
    background: Color(0xFFFAFDFD),
    onBackground: Color(0xFF191C1D),
    surface: Color(0xFFFAFDFD),
    onSurface: Color(0xFF191C1D),
    surfaceVariant: Color(0xFFDBE4E6),
    onSurfaceVariant: Color(0xFF3F484A),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    shadow: Color(0xFF000000),
    outline: Color(0xFF6F797A),
    outlineVariant: Color(0xFFBFC8CA),
    textPrimary: Color(0xFF191C1D),
    textSecondary: Color(0xFF3F484A),
    textTertiary: Color(0xFF6F797A),
    textDisabled: Color(0xFF9DA8AB),
    backgroundVariant: Color(0xFFE8EBEC),
    surfaceDisabled: Color(0x0C000000),
    divider: Color(0x1F1F1F1F),
    border: Color(0xFFDEE3E3),
    cardBackground: Color(0xFFFFFFFF),
  );

  // Dark theme colors
  static const dark = AppColorsExtension(
    primary: Color(0xFF4FD8EB),
    onPrimary: Color(0xFF00363D),
    primaryContainer: Color(0xFF004F58),
    onPrimaryContainer: Color(0xFF97F0FF),
    secondary: Color(0xFFB1CBD0),
    onSecondary: Color(0xFF1C3438),
    secondaryContainer: Color(0xFF334B4F),
    onSecondaryContainer: Color(0xFFCDE7EC),
    background: Color(0xFF191C1D),
    onBackground: Color(0xFFE1E3E3),
    surface: Color(0xFF191C1D),
    onSurface: Color(0xFFE1E3E3),
    surfaceVariant: Color(0xFF3F484A),
    onSurfaceVariant: Color(0xFFBFC8CA),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    shadow: Color(0xFF000000),
    outline: Color(0xFF899294),
    outlineVariant: Color(0xFF3F484A),
    textPrimary: Color(0xFFE1E3E3),
    textSecondary: Color(0xFFBFC8CA),
    textTertiary: Color(0xFF899294),
    textDisabled: Color(0xFF5E6769),
    backgroundVariant: Color(0xFF2C3132),
    surfaceDisabled: Color(0x1FFFFFFF),
    divider: Color(0x33E1E3E3),
    border: Color(0xFF3F484A),
    cardBackground: Color(0xFF1F2425),
  );
}

// Extension method to easily access the custom colors
extension AppColorsExtensionX on ThemeData {
  AppColorsExtension get appColors => extension<AppColorsExtension>()!;
}
