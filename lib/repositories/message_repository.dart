import '../models/message.dart';
import '../config/app_constants.dart';
import '../utils/cache_utils.dart';
import '../utils/logger.dart';
import '../data_sources/message_data_source.dart';

abstract class MessageRepository {
  Future<List<Message>> getMessages(String roomId);
  Future<Message?> getMessageById(String messageId);
  Future<void> sendMessage(Message message);
  Future<List<Message>> searchMessages(String roomId, String query);
  Future<Map<String, List<Message>>> getMessagesByDate(String roomId);
  Future<List<Message>> getRecentMessages(String roomId, int count);
  Future<List<Message>> getMessagesByUser(String roomId, String userId);
  Future<void> refreshMessages(String roomId);
  void clearCache([String? roomId]);
}

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource _remoteDataSource;
  final MessageLocalDataSource? _localDataSource;
  
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
    if (_isCacheValid(roomId)) {
      final cachedMessages = _cachedMessages[roomId]!;
      Logger.cache('캐시 사용', 'messages_$roomId', hit: true);
      return cachedMessages;
    }

    try {
      Logger.info('룸 $roomId 메시지 조회 시작');
      
      final remoteMessages = await _remoteDataSource.fetchMessages(roomId);
      
      List<Message> localMessages = [];
      final localDataSource = _localDataSource;
      if (localDataSource != null) {
        localMessages = await localDataSource.getMessages(roomId);
      }
      
      // 메시지 합치기 및 정렬
      final allMessages = [...remoteMessages, ...localMessages];
      allMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      
      final uniqueMessages = _removeDuplicateMessages(allMessages);
      
      _cachedMessages[roomId] = uniqueMessages;
      _lastFetchTimes[roomId] = DateTime.now();
      
      Logger.info('룸 $roomId 메시지 ${uniqueMessages.length}개 조회 및 캐시 업데이트 완료');
      return uniqueMessages;
    } catch (e) {
      Logger.warning('원격 메시지 조회 실패, 로컬 캐시 확인 중');
      
      final localDataSource = _localDataSource;
      if (localDataSource != null) {
        final localMessages = await localDataSource.getMessages(roomId);
        if (localMessages.isNotEmpty) {
          _cachedMessages[roomId] = localMessages;
          Logger.info('로컬 캐시에서 룸 $roomId 메시지 ${localMessages.length}개 로드');
          return localMessages;
        }
      }
      
      // 캐시된 데이터가 있다면 반환
      if (_cachedMessages.containsKey(roomId)) {
        final cachedMessages = _cachedMessages[roomId]!;
        Logger.info('메모리 캐시에서 룸 $roomId 메시지 ${cachedMessages.length}개 반환');
        return cachedMessages;
      }
      
      Logger.error('모든 데이터 소스에서 메시지 조회 실패', error: e);
      rethrow;
    }
  }

  @override
  Future<Message?> getMessageById(String messageId) async {
    for (final messages in _cachedMessages.values) {
      try {
        final message = messages.firstWhere((message) => message.id == messageId);
        Logger.debug('캐시에서 메시지 ID $messageId 발견');
        return message;
      } on StateError {
        continue;
      }
    }
    
    final localDataSource = _localDataSource;
    if (localDataSource != null) {
      final message = await localDataSource.getMessageById(messageId);
      if (message != null) {
        Logger.debug('로컬에서 메시지 ID $messageId 발견');
        return message;
      }
    }
    
    Logger.warning('메시지 ID $messageId를 찾을 수 없음');
    return null;
  }

  @override
  Future<void> sendMessage(Message message) async {
    try {
      Logger.info('메시지 전송 시작: ${message.content.length > 50 ? '${message.content.substring(0, 50)}...' : message.content}');
      
      final localDataSource = _localDataSource;
      if (localDataSource != null) {
        await localDataSource.saveMessage(message);
      }
      
      if (_cachedMessages.containsKey(message.roomId)) {
        _cachedMessages[message.roomId]!.add(message);
        _cachedMessages[message.roomId]!.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      }
      
      await _remoteDataSource.sendMessage(message);
      
      Logger.info('메시지 전송 성공: 룸 ${message.roomId}');
    } catch (e) {
      Logger.error('메시지 전송 실패', error: e);
      rethrow;
    }
  }

  @override
  Future<List<Message>> searchMessages(String roomId, String query) async {
    final messages = await getMessages(roomId);
    
    if (query.isEmpty) {
      Logger.debug('검색어가 비어있어 전체 메시지 반환');
      return messages;
    }
    
    final results = messages.where((message) {
      final queryLower = query.toLowerCase();
      return message.content.toLowerCase().contains(queryLower) ||
             (message.userName?.toLowerCase().contains(queryLower) ?? false);
    }).toList();
    
    Logger.debug('메시지 검색 완료: "$query" -> ${results.length}개 발견');
    return results;
  }

  @override
  Future<Map<String, List<Message>>> getMessagesByDate(String roomId) async {
    final messages = await getMessages(roomId);
    final Map<String, List<Message>> grouped = {};
    
    for (final message in messages) {
      final dateKey = _formatDateKey(message.timestamp);
      grouped.putIfAbsent(dateKey, () => []).add(message);
    }
    
    Logger.debug('룸 $roomId 메시지 날짜별 그룹화 완료: ${grouped.keys.length}개 날짜');
    return grouped;
  }

  @override
  Future<List<Message>> getRecentMessages(String roomId, int count) async {
    final messages = await getMessages(roomId);
    final sortedMessages = List<Message>.from(messages);
    sortedMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    final recentMessages = sortedMessages.take(count).toList();
    
    Logger.debug('룸 $roomId 최근 메시지 ${recentMessages.length}개 조회');
    return recentMessages;
  }

  @override
  Future<List<Message>> getMessagesByUser(String roomId, String userId) async {
    final messages = await getMessages(roomId);
    final userMessages = messages.where((message) => message.userId == userId).toList();
    
    Logger.debug('룸 $roomId에서 사용자 $userId의 메시지 ${userMessages.length}개 조회');
    return userMessages;
  }

  @override
  Future<void> refreshMessages(String roomId) async {
    Logger.info('룸 $roomId 메시지 강제 새로고침');
    _cachedMessages.remove(roomId);
    _lastFetchTimes.remove(roomId);
    await getMessages(roomId);
  }

  @override
  void clearCache([String? roomId]) {
    if (roomId != null) {
      Logger.info('룸 $roomId 메시지 캐시 클리어');
      _cachedMessages.remove(roomId);
      _lastFetchTimes.remove(roomId);
    } else {
      Logger.info('전체 메시지 캐시 클리어');
      _cachedMessages.clear();
      _lastFetchTimes.clear();
    }
  }

  bool _isCacheValid(String roomId) {
    final lastFetchTime = _lastFetchTimes[roomId];
    return CacheUtils.isCacheValid(lastFetchTime, _cacheValidDuration);
  }

  List<Message> _removeDuplicateMessages(List<Message> messages) {
    final Map<String, Message> uniqueMap = {};
    for (final message in messages) {
      uniqueMap[message.id] = message;
    }
    return uniqueMap.values.toList();
  }

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

  bool hasCachedData(String roomId) => _cachedMessages.containsKey(roomId);
  int getCachedMessageCount(String roomId) => _cachedMessages[roomId]?.length ?? 0;
  DateTime? getLastFetchTime(String roomId) => _lastFetchTimes[roomId];
} 