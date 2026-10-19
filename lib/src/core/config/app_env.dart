import '../platform/platform_info.dart';

/// Environment configuration loaded via `--dart-define`.
/// Automatically resolves the local API host for Web/iOS (`127.0.0.1`)
/// vs Android Emulator (`10.0.2.2`) when no explicit `API_BASE_URL` is passed.
enum AppEnvironment { dev, staging, prod }

abstract final class AppEnv {
  static const String _envName = String.fromEnvironment(
    'ENV',
    defaultValue: 'dev',
  );

  static const String _definedApiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
  );

  /// Returns the configured `API_BASE_URL`, or the platform-appropriate local dev URL:
  /// - Android Emulator: `http://10.0.2.2:8000/api/v1`
  /// - iOS Simulator & Web: `http://127.0.0.1:8000/api/v1`
  static String get apiBaseUrl {
    if (_definedApiBaseUrl.isNotEmpty) {
      return _definedApiBaseUrl;
    }
    if (PlatformInfo.isAndroid) {
      return 'http://10.0.2.2:8000/api/v1';
    }
    return 'http://127.0.0.1:8000/api/v1';
  }

  static AppEnvironment get current => switch (_envName) {
    'prod' => AppEnvironment.prod,
    'staging' => AppEnvironment.staging,
    _ => AppEnvironment.dev,
  };

  static bool get isProduction => current == AppEnvironment.prod;
}
