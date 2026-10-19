import 'failures.dart';

/// Dart 3 functional Result type (`Success<T>` | `Err<T>`) for explicit error handling
/// without requiring external functional programming packages.
sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isError => this is Err<T>;

  R fold<R>({
    required R Function(Failure failure) onFailure,
    required R Function(T data) onSuccess,
  }) => switch (this) {
    Success<T>(:final data) => onSuccess(data),
    Err<T>(:final failure) => onFailure(failure),
  };
}

final class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;
}

final class Err<T> extends Result<T> {
  const Err(this.failure);

  final Failure failure;
}
