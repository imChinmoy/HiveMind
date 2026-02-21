class ServerEntity {
  final String id;
  final String name;
  final String avatar;
  final String description;
  final String ownerId;
  final DateTime? createdAt;
  final DateTime? joinedAt;

  ServerEntity({
    required this.id,
    required this.name,
    required this.avatar,
    required this.description,
    required this.ownerId,
    this.createdAt, 
    this.joinedAt,
  });

  ServerEntity copyWith({
    String? id,
    String? name,
    String? avatar,
    String? description,
    String? ownerId,
    DateTime? createdAt,
  }) {
    return ServerEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      description: description ?? this.description,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
