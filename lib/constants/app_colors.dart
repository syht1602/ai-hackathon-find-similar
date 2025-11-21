import 'package:flutter/material.dart';

/// Application color constants
class AppColors {
  AppColors._();

  // Primary colors
  static const Color seedColor = Color(0xFF0A7C86);
  static const Color scaffoldBackground = Color(0xFFF3F6FB);

  // Chip colors
  static const Color chipBackground = Color(0xFFE6EEF4);
  static const Color chipBackgroundAlt = Color(0xFFF2F5F8);
  static const Color chipBackgroundLight = Color(0xFFF2F4F7);

  // Shadow colors
  static Color cardShadowLight = Colors.black.withValues(alpha: 0.04);
  static Color cardShadowDark = Colors.black.withValues(alpha: 0.08);
  static Color cardShadow = Colors.black.withValues(alpha: 0.05);

  // Border colors
  static Color borderLight = Colors.grey.shade300;
  static const Color borderDefault = Color(0xFFE0E5EB);
  static const Color borderCard = Color(0xFFE3E7ED);

  // Comparison colors
  static Color diffGood = Colors.lightGreen.shade900;
  static Color diffBad = Colors.redAccent.shade200;
  static Color diffNeutral = Colors.amber.shade300;

  // Surface colors (dynamic based on theme)
  static Color getSurfaceWithOpacity(
    BuildContext context, {
    required double alpha,
  }) {
    return Theme.of(context).colorScheme.surface.withValues(alpha: alpha);
  }
}
