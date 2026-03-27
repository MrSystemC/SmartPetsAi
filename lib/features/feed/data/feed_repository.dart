import 'package:dio/dio.dart';

import '../../../core/error/api_exception.dart';
import '../domain/feed_post.dart';

class FeedRepository {
  FeedRepository(this._dio);

  final Dio _dio;

  Future<List<FeedPost>> getFeed() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/feed');
      final payload = response.data ?? <String, dynamic>{};
      final items = (payload['data'] as List<dynamic>? ?? <dynamic>[]);

      return items
          .map((dynamic json) => FeedPost.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response?.data['message']?.toString() ??
                'Не удалось загрузить ленту')
            : 'Не удалось загрузить ленту',
        statusCode: error.response?.statusCode,
      );
    }
  }
}
