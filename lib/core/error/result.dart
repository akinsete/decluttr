import 'app_failure.dart';

sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

final class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  final AppFailure failure;
}

extension ResultX<T> on Result<T> {
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is FailureResult<T>;

  T? get valueOrNull => switch (this) {
        Success(:final value) => value,
        _ => null,
      };

  /// Convenience when the result is known to be success.
  T get value => switch (this) {
        Success(:final value) => value,
        FailureResult(:final failure) =>
          throw StateError('Result is failure: ${failure.code}'),
      };

  AppFailure? get failureOrNull => switch (this) {
        FailureResult(:final failure) => failure,
        _ => null,
      };

  Result<R> map<R>(R Function(T value) transform) => switch (this) {
        Success(:final value) => Success(transform(value)),
        FailureResult(:final failure) => FailureResult(failure),
      };
}
