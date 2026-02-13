import 'dart:convert';
import 'dart:io';

import 'package:frontend/config/constants/app_constants.dart';
import 'package:frontend/config/network/either.dart';
import 'package:frontend/features/auth/data/api/local_datasource.dart';
import 'package:frontend/features/server/data/models/server_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDatasource {
  Future<Either<String, List<ServerModel>>> getServers();
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
}

class RemoteDataSourceImpl implements RemoteDatasource {
  final http.Client client;
  final LocalDatasource localDatasource;

  RemoteDataSourceImpl({required this.client, required this.localDatasource});

  Future<Map<String, String>> _headers() async {
    final token = localDatasource.getAccessToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  @override
  Future<Either<String, ServerModel>> createServer({
    required String name,
    required String description,
    required File avatar,
  }) async {
    try {
      final token = localDatasource.getAccessToken();
      final url = Uri.parse(
        '${AppConstants.apiDevelopmentUrl}${AppEndpoints.createServer}',
      );

      final request = http.MultipartRequest('POST', url);

      request.headers['Authorization'] = 'Bearer ${token}';

      request.fields['name'] = name;
      request.fields['description'] = description;

      request.files.add(
        await http.MultipartFile.fromPath('avatar', avatar.path),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        return Right(ServerModel.fromJson(decoded));
      }

      return Left('Failed: ${response.statusCode}');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ServerModel>>> getServers() async {
    try {
      final url = Uri.parse(
        '${AppConstants.apiDevelopmentUrl}${AppEndpoints.getServers}',
      );

      final response = await client.get(url, headers: await _headers());

      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body);

        final servers = decoded.map((e) => ServerModel.fromJson(e)).toList();

        return Right(servers);
      }

      return Left('Failed: ${response.statusCode}');
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
      final url = Uri.parse(
        '${AppConstants.apiDevelopmentUrl}${AppEndpoints.joinServer}',
      );

      final response = await client.post(
        url,
        headers: await _headers(),
        body: jsonEncode({'serverId': serverId, 'serverName': serverName}),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return Right(ServerModel.fromJson(decoded));
      }

      return Left('Failed: ${response.statusCode}');
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
      final url = Uri.parse(
        '${AppConstants.apiDevelopmentUrl}${AppEndpoints.leaveServer}$serverId',
      );

      final response = await client.delete(url, headers: await _headers());

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return Right(ServerModel.fromJson(decoded));
      }

      return Left('Failed: ${response.statusCode}');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
