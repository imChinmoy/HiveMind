import 'package:frontend/config/core/secure_storage_service.dart';
import 'package:frontend/features/auth/data/models/user_model.dart';
import 'package:hive/hive.dart';

abstract class LocalDatasource {
  Future<UserModel> getUser();
  Future<void> saveUser(UserModel user);
  Future<void> saveAccessToken(String accessToken);
  Future<String?> getAccessToken();
  Future<void> saveRefreshToken(String refreshToken);
  Future<String?> getRefreshToken();
  Future<void> clearTokens();
  Future<void> clearAll();
}

class LocalDatasourceImpl implements LocalDatasource {
  final Box _user = Hive.box('user');
  final SecureStorageService _secureStorage;

  LocalDatasourceImpl({required SecureStorageService secureStorage})
      : _secureStorage = secureStorage;

  
  @override
  Future<UserModel> getUser() async {
    final user = _user.get('user');
    return UserModel.fromJson(Map<String, dynamic>.from(user));
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await _user.put('user', user.toJson());
  }

  @override
  Future<void> saveAccessToken(String accessToken) async {
    await _secureStorage.saveAccessToken(accessToken);
  }

  @override
  Future<String?> getAccessToken() async {
    return await _secureStorage.getAccessToken();
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await _secureStorage.saveRefreshToken(refreshToken);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _secureStorage.getRefreshToken();
  }

  @override
  Future<void> clearTokens() async {
    await _secureStorage.clearAll();
  }

  @override
  Future<void> clearAll() async {
    await _secureStorage.clearAll();
    await _user.clear();
  }
}