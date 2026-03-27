import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log(
      'HTTP ${options.method} ${options.baseUrl}${options.path}',
      name: 'PetsgramNetwork',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    log(
      'HTTP ${response.statusCode} ${response.requestOptions.path}',
      name: 'PetsgramNetwork',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log(
      'HTTP ERROR ${err.response?.statusCode} ${err.requestOptions.path} ${err.message}',
      name: 'PetsgramNetwork',
    );
    handler.next(err);
  }
}
