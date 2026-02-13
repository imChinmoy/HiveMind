import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/auth/data/api/local_datasource.dart';
import 'package:frontend/features/server/data/api/datasource.dart';
import 'package:frontend/features/server/data/repository/server_repository_impl.dart';
import 'package:frontend/features/server/domain/repository/server_repository.dart';
import 'package:http/http.dart' as http;

final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final localDatasourceProvider = Provider<LocalDatasource>((ref) {
  return LocalDatasourceImpl();
});

final remoteDatasourceProvider = Provider<RemoteDatasource>((ref) {
  final client = ref.watch(httpClientProvider);
  final local = ref.watch(localDatasourceProvider);

  return RemoteDataSourceImpl(client: client, localDatasource: local);
});

final serverRepositoryProvider = Provider<ServerRepository>((ref) {
    final remoteDatasource = ref.watch(remoteDatasourceProvider);
    return ServerRepositoryImpl(remoteDatasource: remoteDatasource);
});