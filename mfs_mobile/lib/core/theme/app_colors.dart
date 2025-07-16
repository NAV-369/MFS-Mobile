import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF1E88E5);  // Blue 600
  static const Color primaryLight = Color(0xFF64B5F6);  // Blue 300
  static const Color primaryDark = Color(0xFF1565C0);  // Blue 800
  static const Color shadow = Color(0x29000000); // 16% black for light theme
  static const Color shadowDark = Color(0x1AFFFFFF); // 10% white for dark theme

  // Accent colors
  static const Color accent = Color(0xFF42A5F5);  // Blue 400

  // Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBackgroundDark = Color(0xFF1E1E1E);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFFB5B5BE);
  static const Color textPrimaryDark = Colors.white;
  static const Color textSecondaryDark = Color(0xFFBDBDBD);
  static const Color textTertiaryDark = Color(0xFF757575);

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA000);
  static const Color info = Color(0xFF2196F3);

  // Other Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF424242);
  static const Color disabled = Color(0xFFBDBDBD);
  static const Color disabledButton = Color(0xFFBBDEFB);

  // Transaction Colors
  static const Color income = Color(0xFF4CAF50);
  static const Color expense = Color(0xFFE53935);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF42A5F5),  // Blue 400
      Color(0xFF1E88E5),  // Blue 600
    ],
  );
}