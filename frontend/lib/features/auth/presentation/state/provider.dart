import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/auth/domain/entities/auth_state.dart';
import 'package:frontend/features/auth/presentation/state/di.dart';
import 'package:frontend/features/auth/presentation/state/notifier.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((
  ref,
) {
  final repository = ref.read(authRepositoryProvider);
  return AuthNotifier(repository);
});
