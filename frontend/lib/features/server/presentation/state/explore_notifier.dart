import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/server/domain/entities/server_entity.dart';
import 'package:frontend/features/server/presentation/state/server_provider.dart';


final exploreServersProvider =
    AsyncNotifierProvider.autoDispose<ExploreServersNotifier, List<ServerEntity>>(
  ExploreServersNotifier.new,
);

class ExploreServersNotifier extends AutoDisposeAsyncNotifier<List<ServerEntity>> {
  static const int _limit = 10;

  int _offset = 0;
  bool _hasMore = true;
  bool _isFetching = false;

  bool get isFetching => _isFetching;
  bool get hasMore => _hasMore;

  @override
  Future<List<ServerEntity>> build() async {
    _offset = 0;
    _hasMore = true;
    _isFetching = false;

    return _fetch(offset: 0);
  }

  Future<List<ServerEntity>> _fetch({required int offset}) async {
    final repo = ref.read(serverRepositoryProvider);
    final result = await repo.getServers(limit: _limit, offset: offset);

    return result.fold(
      (e) => throw Exception(e),
      (data) {
        _offset = offset + data.length;
        if (data.length < _limit) _hasMore = false;

        return data;
      },
    );
  }

  Future<void> loadMore() async {
    if (_isFetching || !_hasMore) return;
    if (state is! AsyncData) return;

    _isFetching = true;
    final snapshotOffset = _offset;

    log('loadMore() → fetching offset=$snapshotOffset', name: 'ExploreNotifier');

    final repo = ref.read(serverRepositoryProvider);
    final result = await repo.getServers(limit: _limit, offset: snapshotOffset);

    result.fold(
      (e) => state = AsyncError(e, StackTrace.current),
      (newServers) {
        _offset = snapshotOffset + newServers.length;
        if (newServers.length < _limit) _hasMore = false;
        final existing = state.value ?? [];
        state = AsyncData([...existing, ...newServers]);
      },
    );

    _isFetching = false;
  }

  Future<void> refresh() async {
    _offset = 0;
    _hasMore = true;
    _isFetching = false;
    state = const AsyncLoading();

    state = await AsyncValue.guard(() => _fetch(offset: 0));
  }

  Future<void> joinServer({
    required String serverId,
    required String serverName,
  }) async {
    final repo = ref.read(serverRepositoryProvider);
    final result = await repo.joinServer(serverId: serverId, serverName: serverName);
    result.fold(
      (e) => state = AsyncError(e, StackTrace.current),
      (_) => state = AsyncData(
        (state.value ?? []).where((s) => s.id != serverId).toList(),
      ),
    );
  }

  Future<void> createServer({
    required String name,
    required String description,
    required File avatar,
  }) async {
    final repo = ref.read(serverRepositoryProvider);
    final result = await repo.createServer(
        name: name, description: description, avatar: avatar);
    result.fold(
      (e) => state = AsyncError(e, StackTrace.current),
      (server) => state = AsyncData([server, ...state.value ?? []]),
    );
  }

  Future<void> leaveServer({
    required String serverId,
    required String userId,
  }) async {
    final repo = ref.read(serverRepositoryProvider);
    final result =
        await repo.leaveServer(serverId: serverId, userId: userId);
    result.fold(
      (e) => state = AsyncError(e, StackTrace.current),
      (_) => state = AsyncData(
        (state.value ?? []).where((s) => s.id != serverId).toList(),
      ),
    );
  }
}