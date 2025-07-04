abstract class CustomException implements Exception {
  final String message;
  final String? etc;
  const CustomException({required this.message, this.etc});
}

class NetworkException extends CustomException {
  const NetworkException() : super(message: '통신이 원활하지 않습니다');
}

class UnauthorizedException extends CustomException {
  const UnauthorizedException() : super(message: '부적절한 접근입니다');
}

class ServerException extends CustomException {
  const ServerException() : super(message: 'Interner Server Error');
}

class OverRetryException extends CustomException {
  const OverRetryException() : super(message: '재시도 횟수가 초과되었습니다');
}

class UnKnownException extends CustomException {
  const UnKnownException([String? etc])
      : super(message: '알 수 없는 에러가 발생했습니다', etc: etc);
}
