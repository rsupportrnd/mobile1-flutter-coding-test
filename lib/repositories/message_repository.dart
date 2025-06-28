import '../models/message.dart';
import '../config/app_constants.dart';
import '../utils/cache_utils.dart';

/// 메시지 데이터 Repository 인터페이스
abstract class MessageRepository {
  Future<List<Message>> getMessages(String roomId);
  Future<void> sendMessage(Message message);
  Future<Map<String, List<Message>>> getMessagesByDate(String roomId);
  Future<List<Message>> getRecentMessages(String roomId, int count);
  Future<void> refreshMessages(String roomId);
}

/// 메시지 Repository 구현체
class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource _remoteDataSource;
  final MessageLocalDataSource? _localDataSource;
  
  // Room마다 캐시된 메시지 목록
  final Map<String, List<Message>> _cachedMessages = {};
  final Map<String, DateTime> _lastFetchTimes = {};
  static const Duration _cacheValidDuration = AppConstants.messageCacheValidDuration;

  MessageRepositoryImpl({
    required MessageRemoteDataSource remoteDataSource,
    MessageLocalDataSource? localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<List<Message>> getMessages(String roomId) async {
    // 캐시 체크
    if (_isCacheValid(roomId)) {
      return _cachedMessages[roomId]!;
    }

    try {
      // 원격에서 데이터 가져오기
      final remoteMessages = await _remoteDataSource.fetchMessages(roomId);
      
      // 로컬에서 메시지 가져오기 (새로 전송한 메시지 등)
      List<Message> localMessages = [];
      if (_localDataSource != null) {
        localMessages = await _localDataSource.getMessages(roomId);
      }
      
      // 메시지 합치기 및 정렬
      final allMessages = [...remoteMessages, ...localMessages];
      allMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      
      // 중복 제거 (ID 기준)
      final uniqueMessages = _removeDuplicateMessages(allMessages);
      
      // 캐시 업데이트
      _cachedMessages[roomId] = uniqueMessages;
      _lastFetchTimes[roomId] = DateTime.now();
      
      return uniqueMessages;
    } catch (e) {
      // 원격 실패 시 로컬에서만 가져오기
      if (_localDataSource != null) {
        final localMessages = await _localDataSource.getMessages(roomId);
        if (localMessages.isNotEmpty) {
          _cachedMessages[roomId] = localMessages;
          return localMessages;
        }
      }
      
      // 캐시된 데이터가 있다면 반환
      if (_cachedMessages.containsKey(roomId)) {
        return _cachedMessages[roomId]!;
      }
      
      rethrow;
    }
  }


  @override
  Future<void> sendMessage(Message message) async {
    try {
      // 로컬에 먼저 저장 (즉시 UI 업데이트)
      if (_localDataSource != null) {
        await _localDataSource.saveMessage(message);
      }
      
      // 캐시에 추가
      if (_cachedMessages.containsKey(message.roomId)) {
        _cachedMessages[message.roomId]!.add(message);
        _cachedMessages[message.roomId]!.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      }
      
      // 원격으로 전송 시도 (실제 앱에서는 API 호출)
      // await _remoteDataSource.sendMessage(message);
      
    } catch (e) {
      // 전송 실패 시 로컬에서 메시지 제거 또는 상태 변경
      rethrow;
    }
  }

  @override
  Future<Map<String, List<Message>>> getMessagesByDate(String roomId) async {
    final messages = await getMessages(roomId);
    final Map<String, List<Message>> grouped = {};
    
    for (final message in messages) {
      final dateKey = _formatDateKey(message.timestamp);
      grouped.putIfAbsent(dateKey, () => []).add(message);
    }
    
    return grouped;
  }

  @override
  Future<List<Message>> getRecentMessages(String roomId, int count) async {
    final messages = await getMessages(roomId);
    final sortedMessages = List<Message>.from(messages);
    sortedMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sortedMessages.take(count).toList();
  }

  @override
  Future<void> refreshMessages(String roomId) async {
    _cachedMessages.remove(roomId);
    _lastFetchTimes.remove(roomId);
    await getMessages(roomId);
  }

  /// 특정 룸의 캐시가 유효한지 확인
  bool _isCacheValid(String roomId) {
    final lastFetchTime = _lastFetchTimes[roomId];
    return CacheUtils.isCacheValid(lastFetchTime, _cacheValidDuration);
  }

  // 중복 메시지 제거 (ID 기준)
  List<Message> _removeDuplicateMessages(List<Message> messages) {
    final Map<String, Message> uniqueMap = {};
    for (final message in messages) {
      uniqueMap[message.id] = message;
    }
    return uniqueMap.values.toList();
  }

  // 날짜 키 포맷
  String _formatDateKey(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);
    
    final difference = today.difference(messageDate).inDays;
    
    if (difference == 0) {
      return '오늘';
    } else if (difference == 1) {
      return '어제';
    } else if (difference < 7) {
      return '$difference일 전';
    } else {
      return '${date.year}년 ${date.month}월 ${date.day}일';
    }
  }
}

/// 메시지 원격 데이터 소스 인터페이스
abstract class MessageRemoteDataSource {
  Future<List<Message>> fetchMessages(String roomId);
  Future<void> sendMessage(Message message);
}

/// 메시지 로컬 데이터 소스 인터페이스
abstract class MessageLocalDataSource {
  Future<List<Message>> getMessages(String roomId);
  Future<Message?> getMessageById(String messageId);
  Future<void> saveMessage(Message message);
}