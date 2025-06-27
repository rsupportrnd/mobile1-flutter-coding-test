///에러 종류별 Exception
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException() : super('인증이 필요합니다.');
}

class ForbiddenException extends AppException {
  const ForbiddenException() : super('접근이 거부되었습니다.');
}

class NotFoundException extends AppException {
  const NotFoundException() : super('요청한 리소스를 찾을 수 없습니다.');
}

class ServerException extends AppException {
  const ServerException() : super('서버 오류가 발생했습니다.');
}

class UnknownException extends AppException {
  const UnknownException() : super('알수 없는 에러');
}
