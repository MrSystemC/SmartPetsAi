class AppConfig {
  static const String appName = 'Petsgram AI';
  static const String apiBaseUrl = 'https://api.petsgram.net/v1';
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 20);

  /// `true` by default so the app can run without a live backend.
  static const bool useMockApi = true;
}
