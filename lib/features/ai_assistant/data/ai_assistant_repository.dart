import 'package:dio/dio.dart';

import '../../../core/error/api_exception.dart';

class AiAssistantRepository {
  AiAssistantRepository(this._dio);

  final Dio _dio;

  Future<String> sendMessage(String message) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/ai/chat',
        data: <String, dynamic>{'message': message},
      );
      final payload = response.data ?? <String, dynamic>{};
      final data = payload['data'] as Map<String, dynamic>? ?? <String, dynamic>{};

      return data['reply'] as String? ?? 'Пустой ответ от AI';
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response?.data['message']?.toString() ??
                'AI-сервис временно недоступен')
            : 'AI-сервис временно недоступен',
        statusCode: error.response?.statusCode,
      );
    }
  }
}
