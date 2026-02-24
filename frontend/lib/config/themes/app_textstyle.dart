import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    letterSpacing: 2,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Hunters K-Pop',
  );

  static const TextStyle appbarHeading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w900,
    color: Color.fromARGB(255, 119, 134, 195),
    letterSpacing: 1.2
  );

  static const TextStyle channelTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const TextStyle messageAuthor = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle messageText = TextStyle(
    fontSize: 15,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  static const TextStyle timestamp = TextStyle(
    fontSize: 12,
    color: AppColors.textMuted,
  );

  static const TextStyle hint = TextStyle(
    fontSize: 14,
    color: AppColors.textMuted,
  );
}
