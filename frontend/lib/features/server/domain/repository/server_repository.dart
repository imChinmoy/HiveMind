import 'dart:io';
import 'package:frontend/config/network/either.dart';
import 'package:frontend/features/server/domain/entities/server_entity.dart';

abstract class ServerRepository {
  Future<Either<String, ServerEntity>> createServer({
    required String name,
    required String description,
    required File avatar,
  });

  Future<Either<String, List<ServerEntity>>> getServers();
  Future<Either<String, List<ServerEntity>>> getMyServers();

  Future<Either<String, ServerEntity>> joinServer({
    required String serverId,
    required String serverName,
  });

  Future<Either<String, ServerEntity>> leaveServer({
    required String serverId,
    required String userId,
  });
}
