import 'http_adapter_stub.dart'
    if (dart.library.js_interop) 'http_adapter_web.dart'
    if (dart.library.io) 'http_adapter_io.dart';

/// Contract for HTTP operations across Web, Android, and iOS.
/// Decouples datasources from the concrete HTTP library (e.g., Dio or native adapters).
abstract interface class ApiClient {
  factory ApiClient({String? baseUrl}) =>
      createPlatformApiClient(baseUrl: baseUrl);

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? queryParameters,
  });

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  });
}
