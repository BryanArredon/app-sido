/// Domain-level failures using Dart 3 sealed classes for exhaustive pattern matching.
sealed class Failure {
  const Failure(this.message, {this.code});

  final String message;
  final String? code;
}

final class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code, this.statusCode});

  final int? statusCode;
}

final class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'No se pudo conectar con el servidor. Verifica tu conexión.',
  ]);
}

final class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.code, this.fieldErrors = const {}});

  final Map<String, dynamic> fieldErrors;
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    super.message = 'Sesión expirada o no autorizada.',
  ]);
}
