import 'package:frontend/features/auth/domain/entities/user_entity.dart/user_entity.dart';

class AuthState {
  final bool isLoading;
  final UserEntity? user;
  final String? error;

  const AuthState({this.isLoading = false, this.user, this.error});

  AuthState copyWith({bool? isLoading, UserEntity? user, String? error}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user,
      error: error,
    );
  }
}
