import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config/themes/app_colors.dart';
import 'package:frontend/features/server/domain/entities/server_entity.dart';
import 'package:frontend/features/server/presentation/state/explore_notifier.dart';

class ServerCard extends ConsumerStatefulWidget {
  final ServerEntity server;
  final int index;

  const ServerCard({Key? key, required this.server, required this.index}) : super(key: key);

  @override
  ConsumerState<ServerCard> createState() => _ServerCardState();
}

class _ServerCardState extends ConsumerState<ServerCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  bool _isJoining = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _fade = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));

    final delay = (widget.index * 50).clamp(0, 350);
    Future.delayed(Duration(milliseconds: delay), () {
      if (mounted) _animController.forward();
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown';
    const m = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${m[date.month - 1]} ${date.day}, ${date.year}';
  }

  Future<void> _join() async {
    if (_isJoining) return;
    HapticFeedback.lightImpact();
    setState(() => _isJoining = true);
    await ref.read(exploreServersProvider.notifier).joinServer(
      serverId: widget.server.id,
      serverName: widget.server.name,
    );
    if (mounted) setState(() => _isJoining = false);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
           
            gradient: AppGradients.cardGradient,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider.withOpacity(0.4), width: 0.8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CardHeader(server: widget.server, formatDate: _formatDate),
              Divider(height: 1, thickness: 0.6, color: AppColors.divider.withOpacity(0.35), indent: 16, endIndent: 16),
              _CardActions(isJoining: _isJoining, onJoin: _join),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  final ServerEntity server;
  final String Function(DateTime?) formatDate;

  const _CardHeader({required this.server, required this.formatDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Avatar(avatarUrl: server.avatar),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  server.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (server.description?.isNotEmpty == true) ...[
                  const SizedBox(height: 4),
                  Text(
                    server.description!,
                    style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 11, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(
                      'Created ${formatDate(server.createdAt)}',
                      style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? avatarUrl;

  const _Avatar({this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: avatarUrl != null
          ? Image.network(
              avatarUrl!,
              width: 54,
              height: 54,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _fallback(),
            )
          : _fallback(),
    );
  }

  Widget _fallback() => Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          gradient: AppGradients.avatarGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.group_rounded, color: Colors.white54, size: 26),
      );
}

class _CardActions extends StatelessWidget {
  final bool isJoining;
  final VoidCallback onJoin;

  const _CardActions({required this.isJoining, required this.onJoin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: _JoinButton(isLoading: isJoining, onTap: onJoin),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: _OutlineButton(
              label: 'Preview',
              icon: Icons.visibility_outlined,
              onTap: () {
                HapticFeedback.selectionClick();
                // TODO: preview
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _JoinButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const _JoinButton({required this.isLoading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 38,
        decoration: BoxDecoration(
          color: isLoading ? AppColors.primary.withOpacity(0.6) : AppColors.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isLoading ? [] : [
            BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3)),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login_rounded, size: 15, color: Colors.white),
                    SizedBox(width: 6),
                    Text('Join Server', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                  ],
                ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _OutlineButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.divider.withOpacity(0.6), width: 0.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 15, color: AppColors.textSecondary),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}