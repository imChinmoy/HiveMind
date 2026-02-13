class UserEntity {
  final String id;
  final String email;
  final String username;
  final int age;
  final String? accessToken;
  final String? refreshToken;

  UserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.age,
    this.accessToken,
    this.refreshToken,
  });
}
