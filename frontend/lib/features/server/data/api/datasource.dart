import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:frontend/config/constants/app_constants.dart';
import 'package:frontend/config/network/dio_confg.dart';
import 'package:frontend/config/network/either.dart';
import 'package:frontend/features/server/data/models/server_model.dart';
import 'package:frontend/features/server/data/models/channel_model.dart';
import 'package:frontend/features/server/data/models/message_model.dart';

abstract class RemoteDatasource {
  Future<Either<String, List<ServerModel>>> getMyServers();

  Future<Either<String, ServerModel>> joinServer({
    required String serverId,
    required String serverName,
  });

  Future<Either<String, ServerModel>> leaveServer({
    required String serverId,
    required String userId,
  });

  Future<Either<String, ServerModel>> createServer({
    required String name,
    required String description,
    required File avatar,
  });

  Future<Either<String, List<ServerModel>>> exploreServers({
    required int limit,
    required int offset,
  });

  Future<Either<String, List<ChannelModel>>> getChannels({
    required String serverId,
    required String serverName,
  });

  Future<Either<String, ChannelModel>> createChannel({
    required String serverId,
    required String name,
    String? description,
  });

  Future<Either<String, List<MessageModel>>> getMessages({
    required String channelId,
    int limit = 50,
    String? before,
  });
}

class RemoteDataSourceImpl implements RemoteDatasource {
  final NetworkService networkService;

  RemoteDataSourceImpl({required this.networkService});

  @override
  Future<Either<String, List<ServerModel>>> getMyServers() async {
    try {
      final response = await networkService.dio.get(AppEndpoints.getMyServers);

      final List data = response.data;
      final servers = data.map((e) => ServerModel.fromJson(e)).toList();

      return Right(servers);
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ServerModel>>> exploreServers({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await networkService.dio.get(
        AppEndpoints.getServers,
        queryParameters: {"limit": limit, "offset": offset},
      );

      final List data = response.data;
      final servers = data.map((e) => ServerModel.fromJson(e)).toList();

      return Right(servers);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ServerModel>> joinServer({
    required String serverId,
    required String serverName,
  }) async {
    try {
      final response = await networkService.dio.post(
        AppEndpoints.joinServer,
        data: {'serverId': serverId, 'serverName': serverName},
      );

      return Right(ServerModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ServerModel>> leaveServer({
    required String serverId,
    required String userId,
  }) async {
    try {
      final response = await networkService.dio.delete(
        '${AppEndpoints.leaveServer}$serverId',
      );

      return Right(ServerModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ServerModel>> createServer({
    required String name,
    required String description,
    required File avatar,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'description': description,
        'avatar': await MultipartFile.fromFile(avatar.path),
      });
      log(formData.fields.toString());

      final response = await networkService.dio.post(
        AppEndpoints.createServer,
        data: formData,
      );
      log(response.data.toString());

      return Right(ServerModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ChannelModel>>> getChannels({
    required String serverId,
    required String serverName,
  }) async {
    try {
      final response = await networkService.dio.get(
        AppEndpoints.getChannels,
        queryParameters: {'serverId': serverId, 'serverName': serverName},
      );

      final List data = response.data;
      final channels = data.map((e) => ChannelModel.fromJson(e)).toList();

      return Right(channels);
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ChannelModel>> createChannel({
    required String serverId,
    required String name,
    String? description,
  }) async {
    try {
      final response = await networkService.dio.post(
        AppEndpoints.createChannel,
        data: {
          'serverId': serverId,
          'name': name,
          if (description != null) 'description': description,
        },
      );

      return Right(ChannelModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MessageModel>>> getMessages({
    required String channelId,
    int limit = 50,
    String? before,
  }) async {
    try {
      final response = await networkService.dio.get(
        '${AppEndpoints.getMessages}/$channelId',
        queryParameters: {'limit': limit, if (before != null) 'before': before},
      );

      final List data = response.data;
      final messages = data.map((e) => MessageModel.fromJson(e)).toList();

      return Right(messages);
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  String _handleError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      return e.response?.data['message'] ?? 'Request failed';
    }

    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection timeout';
    }

    if (e.type == DioExceptionType.receiveTimeout) {
      return 'Receive timeout';
    }

    if (e.type == DioExceptionType.connectionError) {
      return 'No internet connection';
    }

    return e.message ?? 'Something went wrong';
  }
}
