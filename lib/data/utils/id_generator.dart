abstract class IdGenerator {
  /// Message DB에서 messageId를 내림차순으로 정렬하여 첫번째 인덱스 id + 1한 값을 return
  Future<String> generateNextMessageId();
}
