import 'dart:convert';
import 'dart:developer';
import 'package:frontend/config/constants/app_constants.dart';
import 'package:frontend/config/network/either.dart';
import 'package:http/http.dart' as http;

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
  @override
  Future<Either<String, Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    try {
      final payload = {'email': email, 'password': password};
      final url = Uri.parse('${AppConstants.apiDevelopmentUrl}/auth/login');
      final response = await http.post(
        url,
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return Right(decoded);
      }else{
        final decoded = jsonDecode(response.body);
        return Left(decoded['message']);
      }
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
      final payload = {
        'username': username,
        'email': email,
        'password': password,
        'age': age,
      };
      final url = Uri.parse('${AppConstants.apiDevelopmentUrl}/auth/signup');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 201) {
        final decoded = jsonDecode(response.body);

        return Right(decoded);
      }

      return Left('Failed to sign up. Status code: ${response.statusCode}');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
