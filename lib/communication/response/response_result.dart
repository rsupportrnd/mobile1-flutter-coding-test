class ResponseResult<T> {
  final bool isSuccess;
  final String message;
  final T data;

  ResponseResult(
      {required this.isSuccess, required this.message, required this.data});
}
