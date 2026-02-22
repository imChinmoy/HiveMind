import 'package:flutter/material.dart';
import 'package:frontend/config/themes/app_colors.dart';

class ExploreEmptyState extends StatelessWidget {
  const ExploreEmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppGradients.appBackground,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.divider.withOpacity(0.4)),
              ),
              child: const Icon(Icons.explore_off_rounded, size: 32, color: AppColors.textMuted),
            ),
            const SizedBox(height: 16),
            const Text(
              'No servers available',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 6),
            const Text(
              'Be the first to create one!',
              style: TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}