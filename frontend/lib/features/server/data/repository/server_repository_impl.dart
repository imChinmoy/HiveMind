import 'dart:io';

import 'package:frontend/config/network/either.dart';
import 'package:frontend/features/server/data/api/datasource.dart';
import 'package:frontend/features/server/data/api/server_local_datasource.dart';
import 'package:frontend/features/server/domain/entities/server_entity.dart';
import 'package:frontend/features/server/domain/repository/server_repository.dart';

class ServerRepositoryImpl implements ServerRepository {
  final RemoteDatasource remoteDatasource;
  final ServerLocalDatasource localDatasource;

  ServerRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  
  @override
  Future<Either<String, List<ServerEntity>>> getMyServers() async {
    final result = await remoteDatasource.getMyServers();

    result.fold(
      (_) {},
      (servers) => localDatasource.cacheMyServers(servers),
    );

    return result;
  }

  @override
  Future<List<ServerEntity>> getCachedMyServers() async {
    return await localDatasource.getCachedMyServers();
  }

  @override
  Future<Either<String, List<ServerEntity>>> getServers({
    required int limit,
    required int offset,
  }) async {
    final result = await remoteDatasource.exploreServers(
      limit: limit,
      offset: offset,
    );

    if (offset == 0) {
      result.fold(
        (_) {},
        (servers) => localDatasource.cacheExploreServers(servers),
      );
    }

    return result;
  }

  @override
  Future<List<ServerEntity>> getCachedExploreServers() async {
    return await localDatasource.getCachedExploreServers();
  }

  @override
  Future<Either<String, ServerEntity>> createServer({
    required String name,
    required String description,
    required File avatar,
  }) async {
    final result = await remoteDatasource.createServer(
      name: name,
      description: description,
      avatar: avatar,
    );


    result.fold((_) {}, (_) {
      localDatasource.clearMyServersCache();
      localDatasource.clearExploreServersCache();
    });

    return result;
  }

  @override
  Future<Either<String, ServerEntity>> joinServer({
    required String serverId,
    required String serverName,
  }) async {
    final result = await remoteDatasource.joinServer(
      serverId: serverId,
      serverName: serverName,
    );

    result.fold((_) {}, (_) {
      localDatasource.clearMyServersCache();
    });

    return result;
  }

  @override
  Future<Either<String, ServerEntity>> leaveServer({
    required String serverId,
    required String userId,
  }) async {
    final result = await remoteDatasource.leaveServer(
      serverId: serverId,
      userId: userId,
    );

    result.fold((_) {}, (_) {
      localDatasource.clearMyServersCache();
    });

    return result;
  }
}
