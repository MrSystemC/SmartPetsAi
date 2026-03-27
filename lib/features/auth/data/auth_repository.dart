import 'package:dio/dio.dart';

import '../../../core/error/api_exception.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../../shared/domain/app_user.dart';
import '../../../shared/domain/auth_session.dart';
import '../domain/login_request.dart';

class AuthRepository {
  AuthRepository(this._dio, this._storage);

  final Dio _dio;
  final SecureStorageService _storage;

  Future<AuthSession> login(LoginRequest request) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: request.toJson(),
      );

      final payload = response.data ?? <String, dynamic>{};
      final data = payload['data'] as Map<String, dynamic>? ?? <String, dynamic>{};
      final token = data['accessToken'] as String? ?? '';
      final user = AppUser.fromJson(
        data['user'] as Map<String, dynamic>? ?? <String, dynamic>{},
      );

      final session = AuthSession(
        accessToken: token,
        user: user,
      );

      await _storage.saveSession(session);
      return session;
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response?.data['message']?.toString() ??
                'Не удалось выполнить вход')
            : 'Не удалось выполнить вход',
        statusCode: error.response?.statusCode,
      );
    }
  }

  Future<AuthSession?> restoreSession() {
    return _storage.readSession();
  }

  Future<void> logout() async {
    await _storage.clearAll();
  }
}
