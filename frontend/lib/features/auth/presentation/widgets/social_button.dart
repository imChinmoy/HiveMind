import 'package:flutter/material.dart';
import 'package:frontend/config/themes/app_colors.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final String assetPath;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.text,
    required this.assetPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.textMuted.withOpacity(0.5)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onPressed,
        icon: Image.asset(assetPath, width: 25, height: 25),
        label: Text(
          text,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
