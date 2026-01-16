import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/auth/domain/entities/auth_state.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repo.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepo repository;

  AuthNotifier(this.repository) : super(const AuthState());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await repository.login(
      username: username,
      password: password,
    );

    (result).fold(
      (error) {
        state = state.copyWith(isLoading: false, error: error);
      },
      (user) {
        state = state.copyWith(isLoading: false, user: user);
      },
    );
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required int age,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await repository.signUp(
      username: username,
      email: email,
      password: password,
      age: age,
    );

    result.fold(
      (error) {
        state = state.copyWith(isLoading: false, error: error);
      },
      (user) {
        state = state.copyWith(isLoading: false, user: user);
      },
    );
  }

  void logout() {
    state = const AuthState();
  }
}
