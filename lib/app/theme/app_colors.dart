import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand palette
  static const Color primary = Color(0xFF20E3FF); // Neon cyan
  static const Color secondary = Color(0xFFFF4FD8); // Electric magenta
  static const Color accent = Color(0xFF7C5CFF); // Hyper violet
  static const Color success = Color(0xFF25D366);
  static const Color warning = Color(0xFFFFC857);
  static const Color danger = Color(0xFFFF4D6D);
  static const Color neutral = Color(0xFFF2F4F8);
  static const Color dark = Color(0xFF0E1116);

  // Surfaces
  static const Color lightBackground = Color(0xFFF6F8FF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF0A0E16);
  static const Color darkSurface = Color(0xFF111827);

  // Gradients
  static const List<Color> neonGradient = [
    Color(0xFF20E3FF),
    Color(0xFF7C5CFF),
  ];
  static const List<Color> magentaGradient = [
    Color(0xFFFF4FD8),
    Color(0xFFFF8A5C),
  ];
}
