import '../models/user.dart';
import '../config/app_constants.dart';
import '../utils/cache_utils.dart';
import '../utils/logger.dart';
import '../data_sources/user_data_source.dart';

/// 사용자 데이터 Repository 인터페이스
abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<User?> getUserById(String userId);
  Future<List<User>> searchUsers(String query);
  Future<void> refreshUsers();
  void clearCache();
}

/// 사용자 Repository 구현체
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource? _localDataSource;
  
  // 캐시된 사용자 목록
  List<User>? _cachedUsers;
  DateTime? _lastFetchTime;
  static const Duration _cacheValidDuration = AppConstants.userCacheValidDuration;

  UserRepositoryImpl({
    required UserRemoteDataSource remoteDataSource,
    UserLocalDataSource? localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<List<User>> getUsers() async {
    // 캐시 체크 - 안전한 접근
    final cachedUsers = _cachedUsers;
    if (_isCacheValid() && cachedUsers != null) {
      Logger.cache('캐시 사용', 'users', hit: true);
      return cachedUsers;
    }

    try {
      Logger.info('사용자 목록 조회 시작');
      
      // 원격에서 데이터 가져오기
      final users = await _remoteDataSource.fetchUsers();
      
      // 캐시 업데이트
      _cachedUsers = users;
      _lastFetchTime = DateTime.now();
      
      // 로컬에 저장 (옵션)
      final localDataSource = _localDataSource;
      if (localDataSource != null) {
        await localDataSource.saveUsers(users);
      }
      
      Logger.info('사용자 ${users.length}명 조회 및 캐시 업데이트 완료');
      return users;
    } catch (e) {
      Logger.warning('원격 데이터 조회 실패, 로컬 캐시 확인 중');
      
      // 원격 실패 시 로컬에서 가져오기 시도
      final localDataSource = _localDataSource;
      if (localDataSource != null) {
        final localUsers = await localDataSource.getUsers();
        if (localUsers.isNotEmpty) {
          _cachedUsers = localUsers;
          Logger.info('로컬 캐시에서 사용자 ${localUsers.length}명 로드');
          return localUsers;
        }
      }
      
      // 캐시된 데이터가 있다면 반환
      final cachedUsers = _cachedUsers;
      if (cachedUsers != null) {
        Logger.info('메모리 캐시에서 사용자 ${cachedUsers.length}명 반환');
        return cachedUsers;
      }
      
      Logger.error('모든 데이터 소스에서 사용자 조회 실패', error: e);
      rethrow;
    }
  }

  @override
  Future<User?> getUserById(String userId) async {
    final users = await getUsers();
    try {
      final user = users.firstWhere((user) => user.id == userId);
      Logger.debug('사용자 ID $userId 조회 성공: ${user.name}');
      return user;
    } on StateError {
      // firstWhere가 요소를 찾지 못했을 때
      Logger.warning('사용자 ID $userId를 찾을 수 없음');
      return null;
    }
  }

  @override
  Future<List<User>> searchUsers(String query) async {
    final users = await getUsers();
    
    if (query.isEmpty) {
      Logger.debug('검색어가 비어있어 전체 사용자 반환');
      return users;
    }
    
    final results = users.where((user) {
      final queryLower = query.toLowerCase();
      return user.name.toLowerCase().contains(queryLower) ||
             user.email.toLowerCase().contains(queryLower);
    }).toList();
    
    Logger.debug('사용자 검색 완료: "$query" -> ${results.length}명 발견');
    return results;
  }

  @override
  Future<void> refreshUsers() async {
    Logger.info('사용자 데이터 강제 새로고침');
    _cachedUsers = null;
    _lastFetchTime = null;
    await getUsers();
  }

  @override
  void clearCache() {
    Logger.info('사용자 캐시 클리어');
    _cachedUsers = null;
    _lastFetchTime = null;
  }

  /// 캐시가 유효한지 확인
  bool _isCacheValid() {
    return CacheUtils.isCacheValid(_lastFetchTime, _cacheValidDuration);
  }
  
  // 캐시 상태 조회 (디버깅용)
  bool get hasCachedData => _cachedUsers != null;
  int get cachedUsersCount => _cachedUsers?.length ?? 0;
  DateTime? get lastFetchTime => _lastFetchTime;
} 