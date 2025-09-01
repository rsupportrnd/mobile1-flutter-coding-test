abstract class ApiResult<T> {
  ApiResult._();

  factory ApiResult.success(T data) = Success<T>._;
  factory ApiResult.error(String exception) = Failure<T>._;
}

class Success<T> extends ApiResult<T> {
  Success._(this.data) : super._();

  final T data;
}

class Failure<T> extends ApiResult<T> {
  Failure._(this.exception) : super._();

  final String exception;
}