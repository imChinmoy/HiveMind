import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config/core/custom_appbar.dart';
import 'package:frontend/config/themes/app_colors.dart';
import 'package:frontend/config/themes/app_textstyle.dart';
import 'package:frontend/features/server/presentation/state/server_notifier.dart';
import 'package:frontend/features/server/presentation/widgets/server_tile.dart';
import 'package:hive/hive.dart';

class MyServersScreen extends ConsumerWidget {
  const MyServersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serversAsync = ref.watch(serverNotifierProvider);
    final user = Hive.box('user').get('user');
    log(user['username']);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          const CustomAppbar(p1title: "Hive", p2title: "Servers"),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(user['username'], style: AppTextStyles.channelTitle),
            ),
          ),

          serversAsync.when(
            data: (servers) {
              if (servers.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text("No servers found")),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final server = servers[index];
                    return ServerTile(
                      avatar: server.avatar,
                      name: server.name,
                      description: server.description,
                    );
                  }, childCount: servers.length),
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stackTrace) => SliverFillRemaining(
              child: Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
