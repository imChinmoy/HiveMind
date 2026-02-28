import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config/core/custom_appbar.dart';
import 'package:frontend/config/core/toast.dart';
import 'package:frontend/config/themes/app_colors.dart';
import 'package:frontend/config/themes/app_textstyle.dart';
import 'package:frontend/features/auth/presentation/state/provider.dart';
import 'package:frontend/features/auth/presentation/state/di.dart';
import 'package:frontend/features/home/presentation/widgets/avatar_widget.dart';
import 'package:frontend/features/profile/presentation/widgets/profile_menu_item.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box('user');
    final userData = userBox.get('user') ?? {};
    final username = userData['username'] ?? 'Unknown User';
    final email = userData['email'] ?? 'No email available';
    final avatar = userData['avatar'] ?? '';

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: AppGradients.appBackground,
        child: CustomScrollView(
          slivers: [
            const CustomAppbar(p1title: "My", p2title: "Profile"),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Avatar and User Info Section
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.surface.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppColors.divider.withOpacity(0.5),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            AvatarWidget(
                              name: username,
                              avatarUrl: avatar.isNotEmpty ? avatar : null,
                              size: 110,
                              isOnline: true,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              username,
                              style: AppTextStyles.heading.copyWith(
                                fontSize: 28,
                                shadows: [
                                  Shadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceDark.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                email,
                                style: AppTextStyles.messageText.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Profile Options
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.divider.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          ProfileMenuItem(
                            icon: Icons.edit_rounded,
                            title: "Edit Profile",
                            onTap: () {
                              ToastHelper.showInfo(
                                context,
                                'Edit Profile coming soon!',
                              );
                            },
                          ),
                          Divider(
                            height: 1,
                            color: AppColors.divider.withOpacity(0.3),
                          ),
                          ProfileMenuItem(
                            icon: Icons.settings_rounded,
                            title: "App Settings",
                            onTap: () {
                              ToastHelper.showInfo(
                                context,
                                'App Settings coming soon!',
                              );
                            },
                          ),
                          Divider(
                            height: 1,
                            color: AppColors.divider.withOpacity(0.3),
                          ),
                          ProfileMenuItem(
                            icon: Icons.help_outline_rounded,
                            title: "Help & Support",
                            onTap: () {
                              ToastHelper.showInfo(
                                context,
                                'Help & Support coming soon!',
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Logout Section
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.danger.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.danger.withOpacity(0.3),
                        ),
                      ),
                      child: ProfileMenuItem(
                        icon: Icons.logout_rounded,
                        title: "Logout",
                        iconColor: AppColors.danger,
                        titleColor: AppColors.danger,
                        onTap: () async {
                          // Show confirmation dialog before logout
                          final shouldLogout = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: AppColors.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: Row(
                                children: [
                                  const Icon(
                                    Icons.warning_amber_rounded,
                                    color: AppColors.danger,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Logout',
                                    style: AppTextStyles.heading.copyWith(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              content: const Text(
                                'Are you sure you want to log out of your account?',
                                style: AppTextStyles.messageText,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: Text(
                                    'Cancel',
                                    style: AppTextStyles.messageText.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.danger,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                  ),
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );

                          if (shouldLogout == true && context.mounted) {
                            await ref
                                .read(authNotifierProvider.notifier)
                                .logout();
                            if (context.mounted) {
                              context.go('/login');
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
