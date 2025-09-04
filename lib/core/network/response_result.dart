class ResponseResult<T> {
  final String code;

  final T data;

  ResponseResult({required this.code, required this.data});

  bool get isSuccess => code == "200";
}
