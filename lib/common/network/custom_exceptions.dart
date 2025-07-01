class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  NetworkException(this.message, {this.statusCode});
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);
}
