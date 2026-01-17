import 'package:frontend/config/network/either.dart';
import 'package:frontend/features/auth/data/api/remote_datasource.dart';
import 'package:frontend/features/auth/data/models/user_model.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final RemoteDataSource remoteDataSource;
  AuthRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<String, UserModel>> login({
    required String username,
    required String password,
  }) async {
    final result = await remoteDataSource.login(
      username: username,
      password: password,
    );
    return result.fold((left) => Left(left), (right) {
      final userModel = UserModel.fromJson(right);
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

    return result.fold((left) => Left(left), (right) {
      final userModel = UserModel.fromJson(right);
      return Right(userModel);
    });
  }

  // @override
  // Future<Either<String, UserEntity>> getUserById({required String id}) {
  //   // TODO: implement getUserById
  //   throw UnimplementedError();
  // }

  @override
  void logout() {}
}
