import 'dart:developer';

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
    
    final repo = ref.read(serverRepositoryProvider);
    final cached = await repo.getCachedMyServers();

    if (cached.isNotEmpty) {
      log('Loaded ${cached.length} servers from cache', name: 'ServerNotifier');

      Future.microtask(() => _refreshInBackground());
      return cached;
    }

    return _fetchMyServers();
  }

  Future<List<ServerEntity>> _fetchMyServers() async {
    final repo = ref.read(serverRepositoryProvider);
    final result = await repo.getMyServers();
    return result.fold(
      (error) => throw Exception(error),
      (servers) => servers,
    );
  }

  Future<void> _refreshInBackground() async {
    try {
      final freshData = await _fetchMyServers();
      state = AsyncData(freshData);
      log('Background refresh complete', name: 'ServerNotifier');
    } catch (e) {
      
      log('Background refresh failed: $e', name: 'ServerNotifier');
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchMyServers());
  }
}
