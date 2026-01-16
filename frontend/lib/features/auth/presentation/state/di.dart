import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/auth/data/api/datasource.dart';
import 'package:frontend/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repo.dart';

final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  return RemoteDataSourceImpl();
});

final authRepositoryProvider = Provider<AuthRepo>((ref) {
  final remoteDataSource = ref.read(remoteDataSourceProvider);
  return AuthRepoImpl(remoteDataSource: remoteDataSource);
});
