import 'package:frontend/config/network/either.dart';
import 'package:frontend/features/auth/domain/entities/user_entity.dart/user_entity.dart';

abstract class AuthRepo {
  Future<Either<String, UserEntity>> signUp({
    required String username,
    required String email,
    required String password,
    required int age
  });
  Future<Either<String, UserEntity>> login({
    required String username,
    required String password,
  });

  void logout();
  // Future<Either<String, UserEntity>> getUserById({required String id});  

}
