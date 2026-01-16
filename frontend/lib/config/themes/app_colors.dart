import 'package:flutter/material.dart';

class AppColors {
  // Core
  static const Color background = Color.fromARGB(0, 0, 0, 0);
  static const Color surface = Color(0xFF2B2D31);
  static const Color surfaceDark = Color(0xFF232428);

  // Primary (Blurple-inspired)
  static const Color primary = Color(0xFF5865F2);
  static const Color primaryHover = Color(0xFF4752C4);

  // Text
  static const Color textPrimary = Color(0xFFF2F3F5);
  static const Color textSecondary = Color(0xFFB5BAC1);
  static const Color textMuted = Color(0xFF949BA4);
  static const Color textPrimaryMuted = Color.fromARGB(255, 70, 73, 104);

  // UI Elements
  static const Color divider = Color(0xFF3F4147);
  static const Color inputBackground = Color(0xFF383A40);

  // Status
  static const Color success = Color(0xFF23A55A);
  static const Color warning = Color(0xFFF0B232);
  static const Color danger = Color(0xFFED4245);
  static const Color online = Color(0xFF23A55A);
  static const Color offline = Color(0xFF80848E);

  // Message bubbles
  static const Color messageSelf = Color(0xFF313338);
  static const Color messageOther = Color(0xFF2B2D31);
}
