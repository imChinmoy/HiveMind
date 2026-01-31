import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/auth/data/api/local_datasource.dart';
import 'package:frontend/features/auth/data/api/remote_datasource.dart';
import 'package:frontend/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repo.dart';

final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  return RemoteDataSourceImpl();
});

final LocalDatasourceProvider = Provider<LocalDatasource>((ref){
  return LocalDatasourceImpl();
});

final authRepositoryProvider = Provider<AuthRepo>((ref) {
  final remoteDataSource = ref.read(remoteDataSourceProvider);
  final localDataSource = ref.read(LocalDatasourceProvider);
  return AuthRepoImpl(remoteDataSource: remoteDataSource, localDataSource: localDataSource);
});
