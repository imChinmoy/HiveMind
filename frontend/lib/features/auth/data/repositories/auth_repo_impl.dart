import 'package:frontend/config/network/either.dart';
import 'package:frontend/features/auth/data/api/local_datasource.dart';
import 'package:frontend/features/auth/data/api/remote_datasource.dart';
import 'package:frontend/features/auth/data/models/user_model.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final RemoteDataSource remoteDataSource;
  final LocalDatasource localDataSource;
  AuthRepoImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  @override
  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    final result = await remoteDataSource.login(
      email: email,
      password: password,
    );

    return await result.fold((left) async => Left(left), (right) async {
      try {
        final accessToken = right['accessToken'];
        final refreshToken = right['refreshToken'];
        final userJson = right['user'];

        if (accessToken == null || refreshToken == null || userJson == null) {
          return Left('Invalid login response from server');
        }

        final userModel = UserModel.fromJson(userJson);

        await localDataSource.saveUser(userModel);
        await localDataSource.saveAccessToken(accessToken.toString());
        await localDataSource.saveRefreshToken(refreshToken.toString());

        return Right(userModel);
      } catch (e) {
        return Left('Login parsing error: ${e.toString()}');
      }
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
