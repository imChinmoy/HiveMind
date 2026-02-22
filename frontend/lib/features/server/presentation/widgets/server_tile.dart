import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/config/themes/app_colors.dart';
import 'package:frontend/config/themes/app_textstyle.dart';

class ServerTile extends StatefulWidget {
  final String name;
  final String? avatar;
  final String? description;
  final VoidCallback onTap;

  const ServerTile({
    Key? key,
    required this.name,
    this.avatar,
    this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ServerTile> createState() => _ServerTileState();
}

class _ServerTileState extends State<ServerTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressController;
  bool _pressed = false;

  Color get _accent {
    const palette = [
      Color(0xFF5865F2),
      Color(0xFF57F287),
      Color(0xFFFEE75C),
      Color(0xFFEB459E),
      Color(0xFF9B59B6),
      Color(0xFFE67E22),
      Color(0xFF3BA55D),
      Color(0xFF1ABC9C),
    ];
    final idx = widget.name.codeUnits.fold(0, (a, b) => a + b) % palette.length;
    return palette[idx];
  }

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 200),
      lowerBound: 0.965,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  void _onTapDown(_) {
    HapticFeedback.selectionClick();
    setState(() => _pressed = true);
    _pressController.reverse();
  }

  void _onTapUp(_) {
    setState(() => _pressed = false);
    _pressController.forward();
  }

  void _onTapCancel() {
    setState(() => _pressed = false);
    _pressController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final accent = _accent;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _pressController,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: AppGradients.cardGradient,
            border: Border.all(
              color: _pressed
                  ? accent.withOpacity(0.6)
                  : AppColors.divider.withOpacity(0.4),
              width: 0.9,
            ),
            boxShadow: _pressed
                ? [
                    BoxShadow(
                      color: accent.withOpacity(0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.28),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                    BoxShadow(
                      color: accent.withOpacity(0.07),
                      blurRadius: 20,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            children: [
              _AvatarBlock(
                avatar: widget.avatar,
                name: widget.name,
                accent: accent,
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.name,
                              style: AppTextStyles.channelTitle.copyWith(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                                letterSpacing: 0.15,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          _ActiveBadge(accent: accent),
                          const SizedBox(width: 12),
                        ],
                      ),
                      if (widget.description?.isNotEmpty == true) ...[
                        const SizedBox(height: 4),
                        Text(
                          widget.description!,
                          style: AppTextStyles.hint.copyWith(
                            fontSize: 12,
                            color: AppColors.textMuted,
                            height: 1.35,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],

                      const SizedBox(height: 8),

                      Container(
                        height: 2,
                        width: 32,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [accent, accent.withOpacity(0)],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.textMuted.withOpacity(0.5),
                  size: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _AvatarBlock extends StatelessWidget {
  final String? avatar;
  final String name;
  final Color accent;

  const _AvatarBlock({this.avatar, required this.name, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: accent.withOpacity(0.3),
                    blurRadius: 14,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),

          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: accent.withOpacity(0.5), width: 1.5),
              gradient: LinearGradient(
                colors: [accent.withOpacity(0.7), accent.withOpacity(0.2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13.5),
              child: avatar != null && avatar!.isNotEmpty
                  ? Image.network(
                      avatar!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _fallback(),
                    )
                  : _fallback(),
            ),
          ),

          Positioned(
            bottom: -1,
            right: -1,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.online,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF252830), width: 2.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.online.withOpacity(0.6),
                    blurRadius: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fallback() => Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      );
}


class _ActiveBadge extends StatelessWidget {
  final Color accent;
  const _ActiveBadge({required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withOpacity(0.3), width: 0.7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(
            'Active',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: accent,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}