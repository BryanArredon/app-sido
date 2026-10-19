import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';

import '../config/app_env.dart';
import '../error/exceptions.dart';
import 'api_client.dart';

@JS('XMLHttpRequest')
extension type _JSXMLHttpRequest._(JSObject _) implements JSObject {
  external factory _JSXMLHttpRequest();
  external void open(String method, String url, [bool async]);
  external void setRequestHeader(String name, String value);
  external void send([JSAny? body]);
  external int get status;
  external String get responseText;
  external set onload(JSFunction? callback);
  external set onerror(JSFunction? callback);
}

ApiClient createPlatformApiClient({String? baseUrl}) =>
    WebApiClient(baseUrl: baseUrl);

/// Browser-compatible HTTP implementation for Flutter Web (JS / Wasm) without `dart:io`.
class WebApiClient implements ApiClient {
  WebApiClient({String? baseUrl}) : _baseUrl = baseUrl ?? AppEnv.apiBaseUrl;

  final String _baseUrl;

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
  }) => _sendRequest('GET', _buildUri(path, queryParameters));

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) => _sendRequest('POST', _buildUri(path), body: body);

  Future<Map<String, dynamic>> _sendRequest(
    String method,
    Uri uri, {
    Map<String, dynamic>? body,
  }) {
    final completer = Completer<Map<String, dynamic>>();
    final xhr = _JSXMLHttpRequest();
    xhr.open(method, uri.toString(), true);
    xhr.setRequestHeader('Accept', 'application/json');
    if (body != null) {
      xhr.setRequestHeader('Content-Type', 'application/json');
    }

    xhr.onload = (() {
      final statusCode = xhr.status;
      final rawText = xhr.responseText;
      final decoded = rawText.isNotEmpty
          ? jsonDecode(rawText) as Map<String, dynamic>
          : <String, dynamic>{};

      if (statusCode >= 200 && statusCode < 300) {
        completer.complete(decoded);
      } else {
        final errorObj = decoded['error'] as Map<String, dynamic>?;
        final message =
            errorObj?['message'] as String? ??
            'Error del servidor ($statusCode)';
        completer.completeError(
          ServerException(message: message, statusCode: statusCode),
        );
      }
    }).toJS;

    xhr.onerror = (() {
      completer.completeError(
        const NetworkException(
          'No se pudo conectar al servidor desde el navegador (verifica CORS o conexión).',
        ),
      );
    }).toJS;

    xhr.send(body != null ? jsonEncode(body).toJS : null);
    return completer.future;
  }
}
