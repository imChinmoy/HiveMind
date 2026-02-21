import 'package:flutter/material.dart';
import 'package:frontend/config/themes/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingAnimationWidget.inkDrop(
        color: AppColors.primary,
        size: 50
    ),
    );
  }
}