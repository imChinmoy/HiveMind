import 'dart:io';

import 'package:frontend/config/network/either.dart';
import 'package:frontend/features/server/data/api/datasource.dart';
import 'package:frontend/features/server/domain/entities/server_entity.dart';
import 'package:frontend/features/server/domain/repository/server_repository.dart';

class ServerRepositoryImpl implements ServerRepository {
  final RemoteDatasource remoteDatasource;

  ServerRepositoryImpl({required this.remoteDatasource});

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

    return result;
  }

  @override
  Future<Either<String, List<ServerEntity>>> getServers() async {
    final result = await remoteDatasource.getServers();

    return result;
  }

  @override
  Future<Either<String, List<ServerEntity>>> getMyServers() async {
    final result = await remoteDatasource.getMyServers();

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

    return result;
  }
}
