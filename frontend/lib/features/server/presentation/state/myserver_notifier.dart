import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/server/domain/entities/server_entity.dart';
import 'package:frontend/features/server/presentation/state/server_provider.dart';

final serverNotifierProvider =
    AsyncNotifierProvider<ServerNotifier, List<ServerEntity>>(
      ServerNotifier.new,
    );

class ServerNotifier extends AsyncNotifier<List<ServerEntity>> {
  @override
  Future<List<ServerEntity>> build() async {
    return _fetchMyServers();
  }

  Future<List<ServerEntity>> _fetchMyServers() async {
    final repo = ref.read(serverRepositoryProvider);

    final result = await repo.getMyServers();

    return result.fold((error) => throw Exception(error), (servers) => servers);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchMyServers());
  }

  
}
