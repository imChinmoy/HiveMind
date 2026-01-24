import 'package:flutter/material.dart';

class AppColors {
  // Core
  static const Color background = Color(0xFF0F1014);
  static const Color surface = Color(0xFF1A1B21);
  static const Color surfaceDark = Color(0xFF14151A);

  // Brand
  static const Color primary = Color(0xFF5865F2);
  static const Color primarySoft = Color(0xFF6D79FF);

  // Text
  static const Color textPrimary = Color(0xFFE6E7EB);
  static const Color textSecondary = Color(0xFFB5BAC1);
  static const Color textMuted = Color(0xFF8E9297);

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

  //Cards
  static const Color cardBackground = Color(0xFF202225);
  // Containers
  static const Color card = Color(0xFF1E1F25);
  static const Color dividerColor = Color(0xFF2A2C34);
}


class AppGradients {
  /// Used ONLY for AppBar
  static const LinearGradient appBarGradient = LinearGradient(
    colors: [
      Color(0xFF1A1B21),
      Color(0xFF15161B),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// Very subtle accent for server rail
  static const LinearGradient serverRailGradient = LinearGradient(
    colors: [
      Color(0xFF1E1F25),
      Color(0xFF18191E),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
