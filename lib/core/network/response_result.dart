class ResponseResult<T> {
  final int code;

  final T data;

  ResponseResult({required this.code, required this.data});

  bool get isSuccess => code == 200;
}
