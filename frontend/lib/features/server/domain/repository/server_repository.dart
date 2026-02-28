import 'dart:io';
import 'package:frontend/config/network/either.dart';
import 'package:frontend/features/server/domain/entities/server_entity.dart';
import 'package:frontend/features/server/domain/entities/channel_entity.dart';
import 'package:frontend/features/server/domain/entities/message_entity.dart';

abstract class ServerRepository {
  Future<Either<String, ServerEntity>> createServer({
    required String name,
    required String description,
    required File avatar,
  });

  Future<Either<String, List<ServerEntity>>> getServers({
    required int limit,
    required int offset,
  });

  Future<Either<String, List<ServerEntity>>> getMyServers();

  Future<Either<String, ServerEntity>> joinServer({
    required String serverId,
    required String serverName,
  });

  Future<Either<String, ServerEntity>> leaveServer({
    required String serverId,
    required String userId,
  });

  Future<Either<String, List<ChannelEntity>>> getChannels({
    required String serverId,
    required String serverName,
  });

  Future<Either<String, ChannelEntity>> createChannel({
    required String serverId,
    required String name,
    String? description,
  });

  Future<Either<String, List<MessageEntity>>> getMessages({
    required String channelId,
    int limit = 50,
    String? before,
  });

  Future<List<ServerEntity>> getCachedMyServers();
  Future<List<ServerEntity>> getCachedExploreServers();
  Future<List<ChannelEntity>> getCachedChannels(String serverId);
  Future<List<MessageEntity>> getCachedMessages(String channelId);
}
