import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config/network/dio_confg.dart';
import 'package:frontend/features/auth/data/api/local_datasource.dart';
import 'package:frontend/features/server/data/api/datasource.dart';
import 'package:frontend/features/server/data/repository/server_repository_impl.dart';
import 'package:frontend/features/server/domain/repository/server_repository.dart';

final localDatasourceProvider = Provider<LocalDatasource>((ref) {
  return LocalDatasourceImpl();
});

final networkServiceProvider = Provider<NetworkService>((ref) {
  final localDatasource = ref.read(localDatasourceProvider);
  return NetworkService(localDatasource: localDatasource);
});

final remoteDatasourceProvider = Provider<RemoteDatasource>((ref) {
  final client = ref.watch(networkServiceProvider);

  return RemoteDataSourceImpl(networkService: client);
});

final serverRepositoryProvider = Provider<ServerRepository>((ref) {
  final remoteDatasource = ref.watch(remoteDatasourceProvider);
  return ServerRepositoryImpl(remoteDatasource: remoteDatasource);
});
