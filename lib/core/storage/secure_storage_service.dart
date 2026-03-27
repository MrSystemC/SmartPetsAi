import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_constants.dart';
import '../../shared/domain/auth_session.dart';

class SecureStorageService {
  SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  Future<void> saveSession(AuthSession session) async {
    await _storage.write(
      key: AppConstants.accessTokenKey,
      value: session.accessToken,
    );
    await _storage.write(
      key: AppConstants.userKey,
      value: jsonEncode(session.toJson()),
    );
  }

  Future<String?> readToken() async {
    return _storage.read(key: AppConstants.accessTokenKey);
  }

  Future<AuthSession?> readSession() async {
    final raw = await _storage.read(key: AppConstants.userKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return AuthSession.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
