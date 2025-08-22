class StorageKeys {
  // 최초 실행, 유저 세션
  static const String firstSeedDone = 'app:firstSeedDone';
  static const String lastUserId = 'app:lastUserId';

  // 룸 마지막 메시지 관리 => 마지막 메시지를 빠르게 찾으려고 저장했으나, 방에도 같은 모델이 있어서 사용 x
  static String roomMeta(String roomId) =>
      'roomMeta:$roomId'; // {lastMessageId, lastMessageAt}

  // 현재 유저 읽음 확인
  static String readReceipt(String roomId, String userId) =>
      'read:$roomId::$userId'; // {lastReadAt}

  // 메시지 방별 관리
  static String roomMessages(String roomId) =>
      'msgs:$roomId'; // List<Map> (정렬된 배열)

  // 유저 / 룸 관계 저장
  static String user(String userId) => 'user:$userId'; // Map
  static String room(String roomId) => 'room:$roomId'; // Map
}
