import 'package:frontend/features/auth/data/models/user_model.dart';
import 'package:hive/hive.dart';

abstract class LocalDatasource {
  Future<UserModel> getUser();
  Future<void> saveUser(UserModel user);
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
}