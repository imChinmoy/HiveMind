import 'package:flutter/material.dart';
import 'package:frontend/config/themes/app_colors.dart';
import 'package:frontend/config/themes/app_textstyle.dart';

class ServerTile extends StatelessWidget {
  final String name;
  final String avatar;
  final String? description;
  const ServerTile({
    Key? key,
    required this.name,
    required this.avatar,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.surface,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(name, style: AppTextStyles.heading),
      ),
    );
  }
}
