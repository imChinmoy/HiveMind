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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: AppGradients.avatarGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [

          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary.withOpacity(0.4), width: 2),
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(avatar),
              backgroundColor: Colors.transparent,
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.channelTitle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2
                  )
                ),
                if (description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    description!,
                    style: AppTextStyles.hint,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),

          // Optional action icon (like settings or join)
          Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textMuted,
            size: 28,
          ),
        ],
      ),
    );
  }
}
