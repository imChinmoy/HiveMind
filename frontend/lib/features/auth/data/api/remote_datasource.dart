import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:frontend/config/constants/app_constants.dart';
import 'package:frontend/config/network/either.dart';
import '../../../../config/network/dio_confg.dart';

abstract class RemoteDataSource {
  Future<Either<String, Map<String, dynamic>>> signUp({
    required String username,
    required String email,
    required String password,
    required int age,
  });

  Future<Either<String, Map<String, dynamic>>> login({
    required String email,
    required String password,
  });
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final NetworkService networkService;

  RemoteDataSourceImpl({required this.networkService});

  @override
  Future<Either<String, Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await networkService.dio.post(
        AppEndpoints.login,
        data: {'email': email, 'password': password},
      );

      return Right(response.data);
    } on DioException catch (e) {
      log(e.toString());

      if (e.response != null && e.response?.data != null) {
        final message = e.response?.data['message'] ?? 'Login failed';
        return Left(message);
      }

      return Left(e.message ?? 'Something went wrong');
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> signUp({
    required String username,
    required String email,
    required String password,
    required int age,
  }) async {
    try {
      final response = await networkService.dio.post(
        AppEndpoints.register,
        data: {
          'username': username,
          'email': email,
          'password': password,
          'age': age,
        },
      );

      return Right(response.data);
    } on DioException catch (e) {
      log(e.toString());

      if (e.response != null && e.response?.data != null) {
        final message = e.response?.data['message'] ?? 'Signup failed';
        return Left(message);
      }

      return Left(e.message ?? 'Something went wrong');
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }
}
