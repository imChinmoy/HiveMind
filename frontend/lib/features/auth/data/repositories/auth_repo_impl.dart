import 'dart:developer';

import 'package:frontend/config/network/either.dart';
import 'package:frontend/features/auth/data/api/local_datasource.dart';
import 'package:frontend/features/auth/data/api/remote_datasource.dart';
import 'package:frontend/features/auth/data/models/user_model.dart';
import 'package:frontend/features/auth/domain/entities/user_entity.dart/user_entity.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final RemoteDataSource remoteDataSource;
  final LocalDatasource localDataSource;
  AuthRepoImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<String, UserModel>> login({
    required String username,
    required String password,
  }) async {
    final result = await remoteDataSource.login(
      username: username,
      password: password,
    );

    return await result.fold((left) async => Left(left), (right) async {
      final userModel = UserModel.fromJson(right);
      await localDataSource.saveUser(userModel);
      return Right(userModel);
    });
  }

  @override
  Future<Either<String, UserModel>> signUp({
    required String username,
    required String email,
    required String password,
    required int age,
  }) async {
    final result = await remoteDataSource.signUp(
      username: username,
      email: email,
      password: password,
      age: age,
    );

    return await result.fold((left) async => Left(left), (right) async {
      final userModel = UserModel.fromJson(right);
      await localDataSource.saveUser(userModel);
      return Right(userModel);
    });
  }

  @override
  void logout() {}

  @override
  Future<Either<String, UserModel>> getCachedUser() async {
    try {
      final user = await localDataSource.getUser();

      return Right(user);
    } catch (e) {
      return Left('NO cached user found');
    }
  }
}
