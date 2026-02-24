import 'package:flutter/material.dart';
import 'package:frontend/config/core/custom_appbar.dart';
import 'package:frontend/config/core/custom_loader.dart';
import 'package:frontend/config/themes/app_colors.dart';
import 'package:frontend/features/server/domain/entities/server_entity.dart';
import 'package:frontend/features/server/presentation/state/explore_notifier.dart';
import 'package:frontend/features/server/presentation/widgets/serach_bar.dart';
import 'package:frontend/features/server/presentation/widgets/server_card.dart';

class ServerList extends StatefulWidget {
  final List<ServerEntity> servers;
  final ScrollController scrollController;
  final ExploreServersNotifier notifier;

  const ServerList({
    Key? key,
    required this.servers,
    required this.scrollController,
    required this.notifier,
  }) : super(key: key);

  @override
  State<ServerList> createState() => _ServerListState();
}

class _ServerListState extends State<ServerList> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppGradients.appBackground,
      child: CustomScrollView(
        controller: widget.scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          const CustomAppbar(p1title: 'Add', p2title: 'Server'),
          SliverSearchBar(
            controller: searchController,
            onChanged: (value) {
              print(value);
            },
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    ServerCard(server: widget.servers[index], index: index),
                childCount: widget.servers.length,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: _PaginationFooter(notifier: widget.notifier),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _PaginationFooter extends StatelessWidget {
  final ExploreServersNotifier notifier;

  const _PaginationFooter({required this.notifier});

  @override
  Widget build(BuildContext context) {
    if (notifier.isFetching) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CustomLoader()),
      );
    }

    if (!notifier.hasMore) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Row(
          children: [
            Expanded(child: Divider(color: AppColors.divider.withOpacity(0.4))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "You've seen it all",
                style: TextStyle(fontSize: 12, color: AppColors.textMuted),
              ),
            ),
            Expanded(child: Divider(color: AppColors.divider.withOpacity(0.4))),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
