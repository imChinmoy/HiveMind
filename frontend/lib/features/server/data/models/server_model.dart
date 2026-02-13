import 'package:frontend/features/server/domain/entities/server_entity.dart';

class ServerModel extends ServerEntity {
  ServerModel({
    required super.id,
    required super.name,
    required super.avatar,
    
    required super.ownerId,
    required super.createdAt, required super.description,
  });

  factory ServerModel.fromJson(Map<String, dynamic> json) {
    return ServerModel(

      id: json['id'] ?? '',
      name: json['name'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      description: json['description'] as String? ?? '',
      ownerId: json['ownerId'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'description': description,
      'ownerId': ownerId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

}
