import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final bool isOnline;
  final double size;
  final bool indicatorTop;

  const AvatarWidget({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.isOnline,
    this.size = 50,
    this.indicatorTop = false,
  });

  @override
  Widget build(BuildContext context) {
    final double indicatorSize = size * 0.28;
    final double nameFontSize = size * 0.26;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: size / 2,
              backgroundColor: Colors.grey.shade900,
              backgroundImage: NetworkImage(avatarUrl),
            ),

            Positioned(
              top: indicatorTop ? 4 : null,
              bottom: indicatorTop ? null : 4,
              right: -2,
              child: Container(
                width: indicatorSize,
                height: indicatorSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isOnline ? Colors.greenAccent : Colors.grey,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: size + 10,
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: nameFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
