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


  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.age,
  }): super(id: id, email: email, username: username, age: age);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      age: json['age'] is int
          ? json['age']
          : int.tryParse(json['age']?.toString() ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'username': username, 'age': age};
  }
}
