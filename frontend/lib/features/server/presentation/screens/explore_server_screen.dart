import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config/core/custom_loader.dart';
import 'package:frontend/config/themes/app_colors.dart';
import 'package:frontend/features/server/presentation/state/explore_notifier.dart';
import 'package:frontend/features/server/presentation/widgets/create_button.dart';
import 'package:frontend/features/server/presentation/widgets/empty.dart';
import 'package:frontend/features/server/presentation/widgets/error.dart';
import 'package:frontend/features/server/presentation/widgets/server_list.dart';

class ExploreServerScreen extends ConsumerStatefulWidget {
  const ExploreServerScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ExploreServerScreen> createState() => _ExploreServerScreenState();
}

class _ExploreServerScreenState extends ConsumerState<ExploreServerScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {

    if (ref.read(exploreServersProvider) is! AsyncData) return;

    final notifier = ref.read(exploreServersProvider.notifier);
    final pos = _scrollController.position;

    if (pos.pixels >= pos.maxScrollExtent - 250 && !notifier.isFetching) {
      notifier.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final serversAsync = ref.watch(exploreServersProvider);
    final notifier = ref.read(exploreServersProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const CreateServerButton(),
      body: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: AppColors.cardBackground,
        onRefresh: notifier.refresh,
        child: serversAsync.when(
          loading: () => const Center(child: CustomLoader()),
          error: (e, _) => ExploreErrorState(
            message: e.toString(),
            onRetry: notifier.refresh,
          ),
          data: (servers) {
            if (servers.isEmpty) return const ExploreEmptyState();
            return ServerList(
              servers: servers,
              scrollController: _scrollController,
              notifier: notifier,
            );
          },
        ),
      ),
    );
  }
}