import 'package:flutter/material.dart';
import 'app_colors.dart';

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color primary;
  final Color error;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color cardBackground;
  final Color divider;
  final Color shadow;

  const AppColorsExtension({
    required this.primary,
    required this.error,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.cardBackground,
    required this.divider,
    required this.shadow,
  });

  @override
  AppColorsExtension copyWith({
    Color? primary,
    Color? error,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? cardBackground,
    Color? divider,
    Color? shadow,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      error: error ?? this.error,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      cardBackground: cardBackground ?? this.cardBackground,
      divider: divider ?? this.divider,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      error: Color.lerp(error, other.error, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
    );
  }
}

const lightAppColors = AppColorsExtension(
  primary: AppColors.primary,
  error: AppColors.error,
  border: AppColors.border,
  textPrimary: AppColors.textPrimary,
  textSecondary: AppColors.textSecondary,
  textTertiary: AppColors.textTertiary,
  cardBackground: AppColors.cardBackground,
  divider: AppColors.divider,
  shadow: AppColors.shadow,
);

const darkAppColors = AppColorsExtension(
  primary: AppColors.primary,
  error: AppColors.error,
  border: Color(0xFF333333),
  textPrimary: AppColors.textPrimaryDark,
  textSecondary: AppColors.textSecondaryDark,
  textTertiary: AppColors.textTertiaryDark,
  cardBackground: AppColors.cardBackgroundDark,
  divider: AppColors.dividerDark,
  shadow: AppColors.shadowDark,
);