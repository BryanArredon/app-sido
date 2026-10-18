/// Infrastructure-level exceptions thrown by DataSources.
class ServerException implements Exception {
  const ServerException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ServerException(statusCode: $statusCode, message: $message)';
}

class NetworkException implements Exception {
  const NetworkException([this.message = 'Sin conexión a internet']);

  final String message;

  @override
  String toString() => 'NetworkException(message: $message)';
}

class CacheException implements Exception {
  const CacheException([this.message = 'Error de almacenamiento local']);

  final String message;

  @override
  String toString() => 'CacheException(message: $message)';
}
