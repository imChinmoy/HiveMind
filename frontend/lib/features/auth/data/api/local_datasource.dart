import 'package:frontend/features/auth/data/models/user_model.dart';
import 'package:hive/hive.dart';

abstract class LocalDatasource {
  Future<UserModel> getUser();
  Future<void> saveUser(UserModel user);
  Future<void> saveAccessToken(String accessToken);
  Future<String?> getAccessToken();
  Future<void> saveRefreshToken(String refreshToken);
  Future<String?> getRefreshToken();
}


class LocalDatasourceImpl implements LocalDatasource {

  final Box _user = Hive.box('user');

  @override
  Future<UserModel> getUser() async {
    final user = _user.get('user');
    return UserModel.fromJson(user);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await _user.put('user', user.toJson());
    
  }
  @override
  Future<void> saveAccessToken(String accessToken) async {
    await _user.put('accessToken', accessToken);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await _user.put('refreshToken', refreshToken);
  }
  @override
  Future<String?> getAccessToken() async {
    return _user.get('accessToken');
  }
  @override
  Future<String?> getRefreshToken() async {
    return _user.get('refreshToken');
  }
}