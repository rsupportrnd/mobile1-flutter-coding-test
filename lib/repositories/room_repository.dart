import '../models/room.dart';
import '../config/app_constants.dart';
import '../utils/cache_utils.dart';
import '../utils/logger.dart';
import '../data_sources/room_data_source.dart';

abstract class RoomRepository {
  Future<List<Room>> getRooms();
  Future<Room?> getRoomById(String roomId);
  Future<List<Room>> searchRooms(String query);
  Future<List<Room>> getActiveRooms();
  Future<List<Room>> getRoomsByCreator(String userId);
  Future<List<Room>> getRoomsSortedByParticipantCount({bool ascending = false});
  Future<List<Room>> getRoomsSortedByLastActivity();
  Future<void> refreshRooms();
  void clearCache();
}

class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDataSource _remoteDataSource;
  final RoomLocalDataSource? _localDataSource;
  
  List<Room>? _cachedRooms;
  DateTime? _lastFetchTime;
  static const Duration _cacheValidDuration = AppConstants.roomCacheValidDuration;

  RoomRepositoryImpl({
    required RoomRemoteDataSource remoteDataSource,
    RoomLocalDataSource? localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<List<Room>> getRooms() async {
    final cachedRooms = _cachedRooms;
    if (_isCacheValid() && cachedRooms != null) {
      Logger.cache('캐시 사용', 'rooms', hit: true);
      return cachedRooms;
    }

    try {
      Logger.info('룸 목록 조회 시작');
      
      final rooms = await _remoteDataSource.fetchRooms();
      
      _cachedRooms = rooms;
      _lastFetchTime = DateTime.now();
      
      final localDataSource = _localDataSource;
      if (localDataSource != null) {
        await localDataSource.saveRooms(rooms);
      }
      
      Logger.info('룸 ${rooms.length}개 조회 및 캐시 업데이트 완료');
      return rooms;
    } catch (e) {
      Logger.warning('원격 데이터 조회 실패, 로컬 캐시 확인 중');
      
      final localDataSource = _localDataSource;
      if (localDataSource != null) {
        final localRooms = await localDataSource.getRooms();
        if (localRooms.isNotEmpty) {
          _cachedRooms = localRooms;
          Logger.info('로컬 캐시에서 룸 ${localRooms.length}개 로드');
          return localRooms;
        }
      }
      
      // 캐시된 데이터가 있다면 반환
      final cachedRooms = _cachedRooms;
      if (cachedRooms != null) {
        Logger.info('메모리 캐시에서 룸 ${cachedRooms.length}개 반환');
        return cachedRooms;
      }
      
      Logger.error('모든 데이터 소스에서 룸 조회 실패', error: e);
      rethrow;
    }
  }

  @override
  Future<Room?> getRoomById(String roomId) async {
    final rooms = await getRooms();
    try {
      final room = rooms.firstWhere((room) => room.id == roomId);
      Logger.debug('룸 ID $roomId 조회 성공: ${room.name}');
      return room;
    } on StateError {
      Logger.warning('룸 ID $roomId를 찾을 수 없음');
      return null;
    }
  }

  @override
  Future<List<Room>> searchRooms(String query) async {
    final rooms = await getRooms();
    
    if (query.isEmpty) {
      Logger.debug('검색어가 비어있어 전체 룸 반환');
      return rooms;
    }
    
    final results = rooms.where((room) {
      final queryLower = query.toLowerCase();
      return room.name.toLowerCase().contains(queryLower) ||
             (room.description?.toLowerCase().contains(queryLower) ?? false) ||
             room.creator.toLowerCase().contains(queryLower);
    }).toList();
    
    Logger.debug('룸 검색 완료: "$query" -> ${results.length}개 발견');
    return results;
  }

  @override
  Future<List<Room>> getActiveRooms() async {
    final rooms = await getRooms();
    final activeRooms = rooms.where((room) => room.isActive).toList();
    
    Logger.debug('활성 룸 조회: 전체 ${rooms.length}개 중 ${activeRooms.length}개');
    return activeRooms;
  }

  @override
  Future<List<Room>> getRoomsByCreator(String userId) async {
    final rooms = await getRooms();
    final creatorRooms = rooms.where((room) => room.creator == userId).toList();
    
    Logger.debug('사용자 $userId가 생성한 룸: ${creatorRooms.length}개');
    return creatorRooms;
  }

  @override
  Future<List<Room>> getRoomsSortedByParticipantCount({bool ascending = false}) async {
    final rooms = await getRooms();
    final sortedRooms = List<Room>.from(rooms);
    sortedRooms.sort((a, b) {
      final result = a.participantCount.compareTo(b.participantCount);
      return ascending ? result : -result;
    });
    
    Logger.debug('참여자 수별 정렬 완료: ${ascending ? '오름차순' : '내림차순'}');
    return sortedRooms;
  }

  @override
  Future<List<Room>> getRoomsSortedByLastActivity() async {
    final rooms = await getRooms();
    final sortedRooms = List<Room>.from(rooms);
    sortedRooms.sort((a, b) {
      final aTime = a.lastMessageTime;
      final bTime = b.lastMessageTime;
      
      if (aTime == null && bTime == null) return 0;
      if (aTime == null) return 1;
      if (bTime == null) return -1;
      
      return bTime.compareTo(aTime);
    });
    
    Logger.debug('최근 활동별 정렬 완료');
    return sortedRooms;
  }

  @override
  Future<void> refreshRooms() async {
    Logger.info('룸 데이터 강제 새로고침');
    _cachedRooms = null;
    _lastFetchTime = null;
    await getRooms();
  }

  @override
  void clearCache() {
    Logger.info('룸 캐시 클리어');
    _cachedRooms = null;
    _lastFetchTime = null;
  }

  bool _isCacheValid() {
    return CacheUtils.isCacheValid(_lastFetchTime, _cacheValidDuration);
  }

  bool get hasCachedData => _cachedRooms != null;
  int get cachedRoomsCount => _cachedRooms?.length ?? 0;
  DateTime? get lastFetchTime => _lastFetchTime;
} 