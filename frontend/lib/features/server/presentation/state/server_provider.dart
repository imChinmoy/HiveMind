import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/auth/presentation/state/di.dart';
import 'package:frontend/features/server/data/api/datasource.dart';
import 'package:frontend/features/server/data/api/server_local_datasource.dart';
import 'package:frontend/features/server/data/repository/server_repository_impl.dart';
import 'package:frontend/features/server/domain/repository/server_repository.dart';

final serverLocalDatasourceProvider = Provider<ServerLocalDatasource>((ref) {
  return ServerLocalDatasourceImpl();
});

final remoteDatasourceProvider = Provider<RemoteDatasource>((ref) {
  final client = ref.watch(networkServiceProvider);
  return RemoteDataSourceImpl(networkService: client);
});

final serverRepositoryProvider = Provider<ServerRepository>((ref) {
  final remoteDatasource = ref.watch(remoteDatasourceProvider);
  final localDatasource = ref.watch(serverLocalDatasourceProvider);
  return ServerRepositoryImpl(
    remoteDatasource: remoteDatasource,
    localDatasource: localDatasource,
  );
});
