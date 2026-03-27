import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../config/app_config.dart';
import '../storage/secure_storage_service.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/mock_api_interceptor.dart';

final flutterSecureStorageProvider = Provider<FlutterSecureStorage>((Ref ref) {
  return const FlutterSecureStorage();
});

final secureStorageProvider = Provider<SecureStorageService>((Ref ref) {
  return SecureStorageService(ref.watch(flutterSecureStorageProvider));
});

final dioProvider = Provider<Dio>((Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: AppConfig.connectTimeout,
      receiveTimeout: AppConfig.receiveTimeout,
      headers: <String, dynamic>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(AuthInterceptor(ref.watch(secureStorageProvider)));
  dio.interceptors.add(LoggingInterceptor());

  if (AppConfig.useMockApi) {
    dio.interceptors.add(MockApiInterceptor());
  }

  return dio;
});
