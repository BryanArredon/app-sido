import 'dart:convert';
import 'dart:io';

import '../config/app_env.dart';
import '../error/exceptions.dart';
import 'api_client.dart';

ApiClient createPlatformApiClient({String? baseUrl}) =>
    IoApiClient(baseUrl: baseUrl);

/// Native HTTP implementation for Android, iOS, and Desktop using `dart:io`.
class IoApiClient implements ApiClient {
  IoApiClient({String? baseUrl}) : _baseUrl = baseUrl ?? AppEnv.apiBaseUrl;

  final String _baseUrl;
  final HttpClient _httpClient = HttpClient()
    ..connectionTimeout = const Duration(seconds: 15);

  Uri _buildUri(String path, [Map<String, String>? queryParameters]) {
    final normalizedBase = _baseUrl.endsWith('/')
        ? _baseUrl.substring(0, _baseUrl.length - 1)
        : _baseUrl;
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$normalizedBase$normalizedPath').replace(
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? queryParameters,
  }) async {
    try {
      final request = await _httpClient.getUrl(_buildUri(path, queryParameters));
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');
      final response = await request.close();
      return _handleResponse(response);
    } on SocketException {
      throw const NetworkException();
    }
  }

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final request = await _httpClient.postUrl(_buildUri(path));
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');
      if (body != null) {
        request.add(utf8.encode(jsonEncode(body)));
      }
      final response = await request.close();
      return _handleResponse(response);
    } on SocketException {
      throw const NetworkException();
    }
  }

  Future<Map<String, dynamic>> _handleResponse(
    HttpClientResponse response,
  ) async {
    final rawBody = await response.transform(utf8.decoder).join();
    final decoded = rawBody.isNotEmpty
        ? jsonDecode(rawBody) as Map<String, dynamic>
        : <String, dynamic>{};

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded;
    }

    final errorObj = decoded['error'] as Map<String, dynamic>?;
    final message =
        errorObj?['message'] as String? ??
        'Error del servidor (${response.statusCode})';
    throw ServerException(message: message, statusCode: response.statusCode);
  }
}
