import '../models/room.dart';
import '../config/app_constants.dart';
import '../utils/cache_utils.dart';

/// 회의실 데이터 Repository 인터페이스
abstract class RoomRepository {
  Future<List<Room>> getRooms();
}

/// 회의실 Repository 구현체
class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDataSource _remoteDataSource;
  final RoomLocalDataSource? _localDataSource;
  
  // 캐시된 회의실 목록
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
    // 캐시 체크
    if (_isCacheValid()) {
      return _cachedRooms!;
    }

    try {
      // 원격에서 데이터 가져오기
      final rooms = await _remoteDataSource.fetchRooms();
      
      // 캐시 업데이트
      _cachedRooms = rooms;
      _lastFetchTime = DateTime.now();
      
      // 로컬에 저장 (옵션)
      if (_localDataSource != null) {
        await _localDataSource.saveRooms(rooms);
      }
      
      return rooms;
    } catch (e) {
      // 원격 실패 시 로컬에서 가져오기 시도
      if (_localDataSource != null) {
        final localRooms = await _localDataSource.getRooms();
        if (localRooms.isNotEmpty) {
          _cachedRooms = localRooms;
          return localRooms;
        }
      }
      
      // 캐시된 데이터가 있다면 반환
      if (_cachedRooms != null) {
        return _cachedRooms!;
      }
      
      rethrow;
    }
  }

  /// 캐시가 유효한지 확인
  bool _isCacheValid() {
    return CacheUtils.isCacheValid(_lastFetchTime, _cacheValidDuration);
  }
}

/// 회의실 원격 데이터 소스 인터페이스
abstract class RoomRemoteDataSource {
  Future<List<Room>> fetchRooms();
}

/// 회의실 로컬 데이터 소스 인터페이스
abstract class RoomLocalDataSource {
  Future<List<Room>> getRooms();
  Future<void> saveRooms(List<Room> rooms);
  Future<void> clearRooms();
} 