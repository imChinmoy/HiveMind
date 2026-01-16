import 'dart:convert';

import 'package:frontend/features/auth/domain/entities/user_entity.dart/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.username,
    required super.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      age: json['age'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, username: $username, age: $age)';
  }

  factory UserModel.fromMap(String data) {
    final Map<String, dynamic> json = jsonDecode(data);
    return UserModel.fromJson(json);
  }
}
