import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config/network/dio_confg.dart';
import 'package:frontend/features/auth/data/api/local_datasource.dart';
import 'package:frontend/features/auth/data/api/remote_datasource.dart';
import 'package:frontend/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repo.dart';

final localDatasourceProvider = Provider<LocalDatasource>((ref) {
  return LocalDatasourceImpl();
});

final networkServiceProvider = Provider<NetworkService>((ref) {
  final localDatasource = ref.read(localDatasourceProvider);
  return NetworkService(localDatasource: localDatasource);
});

final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  final networkService = ref.read(networkServiceProvider);
  return RemoteDataSourceImpl(networkService: networkService);
});

final authRepositoryProvider = Provider<AuthRepo>((ref) {
  final remoteDataSource = ref.read(remoteDataSourceProvider);
  final localDataSource = ref.read(localDatasourceProvider);

  return AuthRepoImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});
