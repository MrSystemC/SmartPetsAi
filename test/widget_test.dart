import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:petsgram_ai_app_v3_ready/app/app.dart';
import 'package:petsgram_ai_app_v3_ready/core/network/dio_provider.dart';
import 'package:petsgram_ai_app_v3_ready/core/storage/secure_storage_service.dart';
import 'package:petsgram_ai_app_v3_ready/shared/domain/auth_session.dart';

class _FakeSecureStorageService extends SecureStorageService {
  _FakeSecureStorageService() : super(const FlutterSecureStorage());

  @override
  Future<AuthSession?> readSession() async => null;

  @override
  Future<String?> readToken() async => null;

  @override
  Future<void> clearAll() async {}

  @override
  Future<void> saveSession(AuthSession session) async {}
}

void main() {
  testWidgets('splash screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          secureStorageProvider.overrideWith((Ref ref) => _FakeSecureStorageService()),
        ],
        child: const PetsgramAiApp(),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
