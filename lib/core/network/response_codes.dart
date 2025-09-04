enum ResponseCodes {
  success("200", "성공"),
  badRequest("400", "입력 정보를 확인해주세요"),
  forbidden("403", "접근 권한이 없습니다"),
  notFound("404", "요청하신 정보를 찾을 수 없습니다"),
  internalServerError("500", "서버에 문제가 발생했습니다"),
  unkownError("999", "알 수 없는 오류가 발생했습니다");

  const ResponseCodes(this.code, this.message);

  final String code;
  final String message;

  static ResponseCodes fromCode(String code) {
    return ResponseCodes.values.firstWhere((e) => e.code == code,
        orElse: () => ResponseCodes.unkownError);
  }
}
