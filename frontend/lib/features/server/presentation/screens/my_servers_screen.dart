import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config/core/custom_appbar.dart';
import 'package:frontend/config/core/custom_loader.dart';
import 'package:frontend/config/themes/app_colors.dart';
import 'package:frontend/config/themes/app_textstyle.dart';
import 'package:frontend/features/server/presentation/state/server_notifier.dart';
import 'package:frontend/features/server/presentation/widgets/server_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class MyServersScreen extends ConsumerWidget {
  const MyServersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = Hive.box('user').get('user');
    final userId = user['id'];

    final serversAsync = ref.watch(serverNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: serversAsync.when(
        data: (servers) {
          final myServers = servers.where((s) => s.ownerId == userId).toList();
          final joinedServers = servers
              .where((s) => s.ownerId != userId)
              .toList();

          return Container(
            decoration: AppGradients.appBackground,
            child: CustomScrollView(
              slivers: [
                const CustomAppbar(p1title: "Hive", p2title: "Servers"),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Text(
                          "Hello , ${user['username']}",
                          style: AppTextStyles.heading,
                        ),
                        const Spacer(),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.surface,
                            border: Border.all(color: AppColors.divider),
                          ),
                          child: GestureDetector(
                            onTap: () => context.push('/add-server'),
                            child: const Icon(
                              Icons.add_business,
                              color: AppColors.primary,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  sliver: const SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.divider,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "My Servers",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.divider,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final server = myServers[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: ServerTile(
                          name: server.name,
                          avatar: server.avatar,
                          description: server.description,
                        ),
                      );
                    }, childCount: myServers.length),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  sliver: const SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.divider,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "Joined Servers",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.divider,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final server = joinedServers[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: ServerTile(
                          name: server.name,
                          avatar: server.avatar,
                          description: server.description,
                        ),
                      );
                    }, childCount: joinedServers.length),
                  ),
                ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
            style: const TextStyle(color: AppColors.danger),
          ),
        ),
        loading: () => const Center(
          child: const CustomLoader()
        ),
      ),
    );
  }
}
