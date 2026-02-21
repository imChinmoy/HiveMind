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

  Future<List<ServerEntity>> fetchServers() async {
    final repo = ref.read(serverRepositoryProvider);

    final result = await repo.getServers();

    return result.fold((error) => throw Exception(error), (servers) => servers);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchMyServers);
  }

  Future<void> createServer({
    required String name,
    required String description,
    required File avatar,
  }) async {
    final repo = ref.read(serverRepositoryProvider);

    final result = await repo.createServer(
      name: name,
      description: description,
      avatar: avatar,
    );

    result.fold(
      (error) {
        state = AsyncError(error, StackTrace.current);
      },
      (server) {
        state = AsyncData([...state.value ?? [], server]);
      },
    );
  }

  Future<ServerEntity> joinServer({
    required String serverId,
    required String serverName,
  }) async {
    final repo = ref.read(serverRepositoryProvider);
    final result = await repo.joinServer(
      serverId: serverId,
      serverName: serverName,
    );
    return result.fold((error) => throw Exception(error), (server) {
      state = AsyncData([...state.value ?? [], server]);
      return server;
    });
  }

  Future<ServerEntity> leaveServer({
    required String serverId,
    required String userId,
  }) async {
    final repo = ref.read(serverRepositoryProvider);
    final result = await repo.leaveServer(serverId: serverId, userId: userId);
    return result.fold((error) => throw Exception(error), (server) {
      state = AsyncData(
        (state.value ?? []).where((s) => s.id != serverId).toList(),
      );
      return server;
    });
  }
}
