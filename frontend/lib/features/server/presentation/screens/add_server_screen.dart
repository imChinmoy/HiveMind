import 'package:flutter/material.dart';
import 'package:frontend/config/core/custom_appbar.dart';
import 'package:frontend/config/themes/app_colors.dart';


final List<Map<String, dynamic>> dummyServers = [
  {
    "id": "1f3a9c10-2c4e-4d6b-8a21-9a7e1b2c0001",
    "name": "HiveMind Devs",
    "avatar": "https://i.pravatar.cc/300?img=1",
    "description": "A community for passionate Flutter and backend developers.",
    "owner": "user-001",
    "createdAt": "2026-01-10T12:30:00.000Z",
    "joinedAt": "2026-01-11T09:00:00.000Z"
  },
  {
    "id": "2b7c8d21-3e5f-4a7b-9c32-1b8e2d3f0002",
    "name": "Design Circle",
    "avatar": "https://i.pravatar.cc/300?img=5",
    "description": "UI/UX designers sharing ideas and feedback.",
    "owner": "user-002",
    "createdAt": "2026-01-05T15:45:00.000Z",
    "joinedAt": "2026-01-06T10:15:00.000Z"
  },
  {
    "id": "3c9d0e32-4f6a-4b8c-a543-2c9f3e4a0003",
    "name": "Startup Lounge",
    "avatar": "https://i.pravatar.cc/300?img=8",
    "description": "Founders, builders, and dreamers discussing startups.",
    "owner": "user-003",
    "createdAt": "2025-12-20T08:00:00.000Z",
    "joinedAt": "2025-12-21T14:30:00.000Z"
  },
  {
    "id": "4d0e1f43-5a7b-4c9d-b654-3d0a4f5b0004",
    "name": "Gaming Arena",
    "avatar": "https://i.pravatar.cc/300?img=12",
    "description": "Daily gaming sessions and tournaments.",
    "owner": "user-004",
    "createdAt": "2026-02-01T18:20:00.000Z",
    "joinedAt": "2026-02-02T11:10:00.000Z"
  },
  {
    "id": "5e1f2a54-6b8c-4dab-c765-4e1b5a6c0005",
    "name": "AI Enthusiasts",
    "avatar": "https://i.pravatar.cc/300?img=15",
    "description": "Exploring machine learning and artificial intelligence.",
    "owner": "user-005",
    "createdAt": "2026-01-18T10:00:00.000Z",
    "joinedAt": "2026-01-19T09:45:00.000Z"
  },
  {
    "id": "6f2a3b65-7c9d-4ebc-d876-5f2c6b7d0006",
    "name": "Music Vibes",
    "avatar": "https://i.pravatar.cc/300?img=20",
    "description": "Share your favorite playlists and discover new music.",
    "owner": "user-006",
    "createdAt": "2025-12-01T13:10:00.000Z",
    "joinedAt": "2025-12-02T16:00:00.000Z"
  },
  {
    "id": "7a3b4c76-8d0e-4fcd-e987-6a3d7c8e0007",
    "name": "Cyber Security Hub",
    "avatar": "https://i.pravatar.cc/300?img=25",
    "description": "Discussing ethical hacking and cyber defense.",
    "owner": "user-007",
    "createdAt": "2026-02-05T09:30:00.000Z",
    "joinedAt": "2026-02-06T12:00:00.000Z"
  },
  {
    "id": "8b4c5d87-9e1f-4ade-f098-7b4e8d9f0008",
    "name": "Book Club",
    "avatar": "https://i.pravatar.cc/300?img=30",
    "description": "Monthly book discussions and recommendations.",
    "owner": "user-008",
    "createdAt": "2025-11-15T17:00:00.000Z",
    "joinedAt": "2025-11-16T18:30:00.000Z"
  }
];

class AddServerScreen extends StatefulWidget {
  const AddServerScreen({Key? key}) : super(key: key);

  @override
  _AddServerScreenState createState() => _AddServerScreenState();
}

class _AddServerScreenState extends State<AddServerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppGradients.appBackground,
        child: CustomScrollView(
          slivers: [
            CustomAppbar(p1title: 'Add', p2title: 'Server'),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final server = dummyServers[index];
                    return _ServerCard(server: server);
                  },
                  childCount: dummyServers.length,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _CreateServerButton(),
    );
  }
}

class _ServerCard extends StatelessWidget {
  final Map<String, dynamic> server;

  const _ServerCard({required this.server});

  String _formatDate(String isoDate) {
    final date = DateTime.tryParse(isoDate);
    if (date == null) return '';
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.divider.withOpacity(0.5),
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top Section: avatar + info ──
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    server['avatar'] as String,
                    width: 54,
                    height: 54,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: AppGradients.avatarGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.group, color: Colors.white54, size: 28),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // Name + description + meta
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        server['name'] as String,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        server['description'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined,
                              size: 11, color: AppColors.textMuted),
                          const SizedBox(width: 4),
                          Text(
                            'Created ${_formatDate(server['createdAt'] as String)}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Divider ──
          Divider(
            height: 1,
            thickness: 0.6,
            color: AppColors.divider.withOpacity(0.4),
            indent: 16,
            endIndent: 16,
          ),

          // ── Bottom Section: buttons ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            child: Row(
              children: [
                // Join Server button
                Expanded(
                  child: _CardButton(
                    label: 'Join Server',
                    icon: Icons.login_rounded,
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    onTap: () {
                      // TODO: join server action
                    },
                  ),
                ),
                const SizedBox(width: 10),
                // Preview button
                Expanded(
                  child: _CardButton(
                    label: 'Preview',
                    icon: Icons.visibility_outlined,
                    backgroundColor: AppColors.surface,
                    foregroundColor: AppColors.textSecondary,
                    borderColor: AppColors.divider,
                    onTap: () {
                      // TODO: preview server action
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final VoidCallback onTap;

  const _CardButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 0.8)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 15, color: foregroundColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: foregroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateServerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceDark,
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        12 + MediaQuery.of(context).padding.bottom,
      ),
      child: GestureDetector(
        onTap: () {
          // TODO: create server action
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_rounded, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'Create a Server',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}