import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand palette
  static const Color primary = Color(0xFFF44D24); // Warm orange
  static const Color secondary = Color(0xFF6B4EFF); // Deep purple
  static const Color accent = Color(0xFFFFEEE6); // Golden amber
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color danger = Color(0xFFFF5252);
  static const Color neutral = Color(0xFFF3F3F5);
  static const Color dark = Color(0xFF2C2C2C);

  // Surfaces
  static const Color lightBackground = neutral;
  static const Color lightSurface = Colors.white;
  static const Color darkBackground = dark;
  static const Color darkSurface = dark;

  // Intentionally no gradients per UI direction.
}
