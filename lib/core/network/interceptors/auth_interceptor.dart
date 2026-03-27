import 'package:dio/dio.dart';

import '../../storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._storageService);

  final SecureStorageService _storageService;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storageService.readToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
