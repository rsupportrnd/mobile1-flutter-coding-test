import 'dart:convert';
import '../models/user.dart';
import '../models/room.dart';
import '../models/message.dart';

/// 캐시 관련 유틸리티 함수들을 제공하는 클래스
/// 캐시 유효성 검사, 시간 계산, 포맷팅 등의 기능을 포함
class CacheUtils {
  // 생성자를 private으로 만들어 인스턴스화 방지
  CacheUtils._();

  /// 캐시가 유효한지 확인
  /// 
  /// [lastFetchTime] 마지막 데이터 가져온 시간
  /// [validDuration] 캐시 유효 기간
  /// 
  /// Returns: 캐시가 유효하면 true, 그렇지 않으면 false
  static bool isCacheValid(DateTime? lastFetchTime, Duration validDuration) {
    if (lastFetchTime == null) return false;
    
    // 음수 duration 처리
    if (validDuration.isNegative) return false;
    
    // Duration.zero인 경우 항상 유효로 처리
    if (validDuration == Duration.zero) return true;
    
    final now = DateTime.now();
    final difference = now.difference(lastFetchTime);
    
    // 정확히 경계에 있을 때도 유효로 처리
    return difference <= validDuration;
  }

  /// 캐시의 나이(age)를 계산
  /// 
  /// [lastFetchTime] 마지막 데이터 가져온 시간
  /// 
  /// Returns: 현재 시간과의 차이를 Duration으로 반환
  static Duration getCacheAge(DateTime? lastFetchTime) {
    if (lastFetchTime == null) return Duration.zero;
    
    final now = DateTime.now();
    return now.difference(lastFetchTime);
  }

  /// 캐시 나이를 사용자 친화적인 문자열로 포맷팅
  /// 
  /// [age] 캐시의 나이 (Duration)
  /// 
  /// Returns: 한국어로 포맷된 시간 문자열
  static String formatCacheAge(Duration age) {
    if (age.isNegative) return '미래';
    if (age == Duration.zero) return '방금 전';
    
    if (age.inDays > 0) {
      return '${age.inDays}일 전';
    } else if (age.inHours > 0) {
      return '${age.inHours}시간 전';
    } else if (age.inMinutes > 0) {
      return '${age.inMinutes}분 전';
    } else {
      return '${age.inSeconds}초 전';
    }
  }

  /// 캐시를 새로고침해야 하는지 확인
  /// 
  /// [lastFetchTime] 마지막 데이터 가져온 시간
  /// [validDuration] 캐시 유효 기간
  /// 
  /// Returns: 새로고침이 필요하면 true, 그렇지 않으면 false
  static bool shouldRefreshCache(DateTime? lastFetchTime, Duration validDuration) {
    return !isCacheValid(lastFetchTime, validDuration);
  }

  /// 캐시 키 생성
  /// 
  /// [prefix] 키 접두사
  /// [identifier] 식별자
  /// 
  /// Returns: 생성된 캐시 키
  static String generateCacheKey(String prefix, String identifier) {
    return '${prefix}_$identifier';
  }

  /// 캐시 통계 정보 생성
  /// 
  /// [lastFetchTime] 마지막 데이터 가져온 시간
  /// [validDuration] 캐시 유효 기간
  /// [dataCount] 캐시된 데이터 개수
  /// 
  /// Returns: 캐시 통계 정보가 담긴 Map
  static Map<String, dynamic> getCacheStats(
    DateTime? lastFetchTime,
    Duration validDuration,
    int dataCount,
  ) {
    final age = getCacheAge(lastFetchTime);
    final isValid = isCacheValid(lastFetchTime, validDuration);
    
    return {
      'lastFetchTime': lastFetchTime?.toIso8601String(),
      'age': formatCacheAge(age),
      'ageInSeconds': age.inSeconds,
      'isValid': isValid,
      'dataCount': dataCount,
      'validDurationInSeconds': validDuration.inSeconds,
    };
  }

  /// 만료 시간 계산
  /// 
  /// [lastFetchTime] 마지막 데이터 가져온 시간
  /// [validDuration] 캐시 유효 기간
  /// 
  /// Returns: 캐시 만료 시간
  static DateTime? getExpirationTime(DateTime? lastFetchTime, Duration validDuration) {
    if (lastFetchTime == null) return null;
    return lastFetchTime.add(validDuration);
  }

  /// 만료까지 남은 시간 계산
  /// 
  /// [lastFetchTime] 마지막 데이터 가져온 시간
  /// [validDuration] 캐시 유효 기간
  /// 
  /// Returns: 만료까지 남은 시간, 이미 만료되었으면 null
  static Duration? getTimeUntilExpiration(DateTime? lastFetchTime, Duration validDuration) {
    final expirationTime = getExpirationTime(lastFetchTime, validDuration);
    if (expirationTime == null) return null;
    
    final now = DateTime.now();
    final timeUntilExpiration = expirationTime.difference(now);
    
    return timeUntilExpiration.isNegative ? null : timeUntilExpiration;
  }

  /// JSON 리스트를 객체 리스트로 변환
  static List<T> jsonListToObjects<T>(
    List<String> jsonList, 
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return jsonList
        .map((jsonStr) => fromJson(json.decode(jsonStr)))
        .toList();
  }

  /// 객체 리스트를 JSON 리스트로 변환  
  static List<String> objectsToJsonList<T>(
    List<T> objects,
    Map<String, dynamic> Function(T) toJson,
  ) {
    return objects
        .map((obj) => json.encode(toJson(obj)))
        .toList();
  }

  /// 사용자 캐시 변환 헬퍼
  static List<User> jsonListToUsers(List<String> jsonList) {
    return jsonListToObjects(jsonList, User.fromJson);
  }

  static List<String> usersToJsonList(List<User> users) {
    return objectsToJsonList(users, (user) => user.toJson());
  }

  /// 회의실 캐시 변환 헬퍼
  static List<Room> jsonListToRooms(List<String> jsonList) {
    return jsonListToObjects(jsonList, Room.fromJson);
  }

  static List<String> roomsToJsonList(List<Room> rooms) {
    return objectsToJsonList(rooms, (room) => room.toJson());
  }

  /// 메시지 캐시 변환 헬퍼
  static List<Message> jsonListToMessages(List<String> jsonList) {
    return jsonListToObjects(jsonList, Message.fromJson);
  }

  static List<String> messagesToJsonList(List<Message> messages) {
    return objectsToJsonList(messages, (message) => message.toJson());
  }

  /// 날짜 문자열 변환 헬퍼
  static String dateTimeToString(DateTime dateTime) {
    return dateTime.toIso8601String();
  }

  static DateTime? stringToDateTime(String? dateStr) {
    if (dateStr == null) return null;
    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      return null;
    }
  }
} 