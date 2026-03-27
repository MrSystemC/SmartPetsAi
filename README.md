# Petsgram AI Android Release

Финальный Flutter-проект для Android.

## Что внутри
- Flutter + Dart
- Dio
- Riverpod
- GoRouter
- Flutter Secure Storage
- mock API по умолчанию
- восстановление сессии после перезапуска
- GitHub Actions для APK и AAB
- Android-конфигурация под Java 17

## Быстрый старт
```bash
flutter pub get
flutter run
```

## Release-сборка
```bash
flutter test
flutter analyze
flutter build apk --release
flutter build appbundle --release
```

## Реальный backend
Файл:
`lib/core/config/app_config.dart`

По умолчанию:
- `useMockApi = true`

Для подключения реального API:
- поменять на `false`
- задать актуальный `apiBaseUrl`

## Подпись релиза
Создать файл:
`android/key.properties`

Шаблон:
```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=upload
storeFile=upload-keystore.jks
```

Keystore положить в:
`android/app/upload-keystore.jks`

## CI
Workflow:
`.github/workflows/flutter-apk.yml`

Собирает:
- `app-release.apk`
- `app-release.aab`

## Проверено по структуре проекта
- все импорты существуют
- все используемые asset-файлы на месте
- Android manifest, Gradle и Kotlin entrypoint присутствуют

## Ограничение среды
В этой среде не было Flutter SDK и Gradle wrapper jar, поэтому фактический запуск `flutter pub get`, `flutter test`, `flutter analyze` и реальная сборка APK/AAB здесь недоступны. Исходники и конфигурация доведены до состояния, подготовленного под локальную сборку и CI.
