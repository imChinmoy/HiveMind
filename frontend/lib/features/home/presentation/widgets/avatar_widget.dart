import "package:flutter/material.dart";
class AvatarWidget extends StatelessWidget {
  final String avatarUrl;
  final bool isOnline;
  final double size;
  final bool indicatorTop;

  const AvatarWidget({
    super.key,
    required this.avatarUrl,
    required this.isOnline,
    this.size = 50,
    this.indicatorTop = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade900,
            image: DecorationImage(
              image: NetworkImage(avatarUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),


        Positioned(
          top: indicatorTop ? 6 : null,
          bottom: indicatorTop ? null : 6,
          right: -2,
          child: Container(
            width: 14,
            height: 14,
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
    );
  }
}
