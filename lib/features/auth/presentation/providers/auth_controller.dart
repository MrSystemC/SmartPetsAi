import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../../../shared/domain/auth_session.dart';
import '../../data/auth_repository.dart';
import '../../domain/login_request.dart';

final authRepositoryProvider = Provider<AuthRepository>((Ref ref) {
  return AuthRepository(
    ref.watch(dioProvider),
    ref.watch(secureStorageProvider),
  );
});

class AuthState {
  const AuthState({
    this.session,
    this.isLoading = false,
    this.errorMessage,
    this.isInitialized = false,
  });

  final AuthSession? session;
  final bool isLoading;
  final String? errorMessage;
  final bool isInitialized;

  AuthState copyWith({
    AuthSession? session,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    bool clearSession = false,
    bool? isInitialized,
  }) {
    return AuthState(
      session: clearSession ? null : (session ?? this.session),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._repository) : super(const AuthState());

  final AuthRepository _repository;

  Future<void> restoreSession() async {
    if (state.isInitialized) {
      return;
    }

    try {
      final session = await _repository.restoreSession();
      state = state.copyWith(
        session: session,
        isInitialized: true,
        clearError: true,
      );
    } catch (_) {
      state = state.copyWith(isInitialized: true);
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final session = await _repository.login(
        LoginRequest(email: email, password: password),
      );
      state = state.copyWith(
        isLoading: false,
        session: session,
        isInitialized: true,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
        isInitialized: true,
      );
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = state.copyWith(
      clearSession: true,
      clearError: true,
      isInitialized: true,
    );
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((Ref ref) {
  return AuthController(ref.watch(authRepositoryProvider));
});
