import 'package:frontend/features/auth/domain/entities/user_entity.dart/user_entity.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends UserEntity {
  @HiveField(0)
  String id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String email;

  @HiveField(3)
  int age;

  @HiveField(4)
  String? accessToken;

  @HiveField(5)
  String? refreshToken;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.age,
    this.accessToken,
    this.refreshToken,
  }) : super(
         id: id,
         email: email,
         username: username,
         age: age,
         accessToken: accessToken,
         refreshToken: refreshToken,
       );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      age: json['age'] is int
          ? json['age']
          : int.tryParse(json['age']?.toString() ?? '') ?? 0,
      accessToken: json['accessToken']?.toString() ?? '',
      refreshToken: json['refreshToken']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'age': age,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
