import 'package:dio/dio.dart';

import '../../../core/error/api_exception.dart';
import '../domain/pet.dart';

class PetsRepository {
  PetsRepository(this._dio);

  final Dio _dio;

  Future<List<Pet>> getPets() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/pets');
      final payload = response.data ?? <String, dynamic>{};
      final items = (payload['data'] as List<dynamic>? ?? <dynamic>[]);

      return items
          .map((dynamic json) => Pet.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response?.data['message']?.toString() ??
                'Не удалось загрузить питомцев')
            : 'Не удалось загрузить питомцев',
        statusCode: error.response?.statusCode,
      );
    }
  }
}
