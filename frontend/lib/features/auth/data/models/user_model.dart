import 'package:frontend/features/auth/domain/entities/user_entity.dart/user_entity.dart';

class UserModel extends UserEntity {
  String id;
  String username;
  String email;
  int age;
  String? accessToken;
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
