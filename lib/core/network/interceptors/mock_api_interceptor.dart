import 'dart:async';

import 'package:dio/dio.dart';

class MockApiInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));

    if (options.path.endsWith('/auth/login') && options.method == 'POST') {
      final payload = options.data as Map<String, dynamic>? ?? <String, dynamic>{};
      handler.resolve(
        Response<dynamic>(
          requestOptions: options,
          statusCode: 200,
          data: <String, dynamic>{
            'data': <String, dynamic>{
              'accessToken': 'mock_access_token_123',
              'user': <String, dynamic>{
                'id': 'u_001',
                'name': 'Anna Petlover',
                'email': payload['email']?.toString() ?? 'anna@petsgram.net',
              },
            },
          },
        ),
      );
      return;
    }

    if (options.path.endsWith('/feed') && options.method == 'GET') {
      handler.resolve(
        Response<dynamic>(
          requestOptions: options,
          statusCode: 200,
          data: <String, dynamic>{
            'data': <Map<String, dynamic>>[
              <String, dynamic>{
                'id': 'p1',
                'authorName': 'Olga & Luna',
                'authorAvatar': '',
                'petName': 'Luna',
                'text': 'Сегодня Luna впервые сходила в dog-friendly кафе и собрала полкафе поклонников.',
                'imageUrl': '',
                'likes': 128,
                'comments': 14,
                'createdAt': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
              },
              <String, dynamic>{
                'id': 'p2',
                'authorName': 'Max & Archie',
                'authorAvatar': '',
                'petName': 'Archie',
                'text': 'Собираю советы по умным игрушкам для активных биглей. Что реально работает?',
                'imageUrl': '',
                'likes': 64,
                'comments': 22,
                'createdAt': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
              },
            ],
          },
        ),
      );
      return;
    }

    if (options.path.endsWith('/pets') && options.method == 'GET') {
      handler.resolve(
        Response<dynamic>(
          requestOptions: options,
          statusCode: 200,
          data: <String, dynamic>{
            'data': <Map<String, dynamic>>[
              <String, dynamic>{
                'id': 'pet_1',
                'name': 'Luna',
                'type': 'Собака',
                'breed': 'Корги',
                'age': '2 года',
                'weight': '11 кг',
                'about': 'Энергичная, очень любит мячики и поездки на машине.',
              },
              <String, dynamic>{
                'id': 'pet_2',
                'name': 'Milo',
                'type': 'Кошка',
                'breed': 'Британская короткошёрстная',
                'age': '4 года',
                'weight': '5.4 кг',
                'about': 'Домашний философ, предпочитает наблюдать за людьми с подоконника.',
              },
            ],
          },
        ),
      );
      return;
    }

    if (options.path.endsWith('/ai/chat') && options.method == 'POST') {
      final payload = options.data as Map<String, dynamic>? ?? <String, dynamic>{};
      final message = payload['message']?.toString() ?? '';
      handler.resolve(
        Response<dynamic>(
          requestOptions: options,
          statusCode: 200,
          data: <String, dynamic>{
            'data': <String, dynamic>{
              'reply': 'AI-помощник Petsgram: по запросу "$message" начните с безопасного чек-листа, наблюдения за симптомами и персонального плана ухода. Это не диагноз и не замена ветеринару.',
            },
          },
        ),
      );
      return;
    }

    handler.next(options);
  }
}
