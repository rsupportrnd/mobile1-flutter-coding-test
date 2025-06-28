import '../models/user.dart';
import '../config/app_constants.dart';
import '../utils/cache_utils.dart';

/// 사용자 데이터 Repository 인터페이스
abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<void> refreshUsers();
}

/// 사용자 Repository 구현체
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource? _localDataSource;
  
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
    final cachedUsers = _cachedUsers;
    if (_isCacheValid() && cachedUsers != null) {
      return cachedUsers;
    }

    try {
      final users = await _remoteDataSource.fetchUsers();
      
      _cachedUsers = users;
      _lastFetchTime = DateTime.now();
      
      final localDataSource = _localDataSource;
      if (localDataSource != null) {
        await localDataSource.saveUsers(users);
      }
      
      return users;
    } catch (e) {
      final localDataSource = _localDataSource;
      if (localDataSource != null) {
        final localUsers = await localDataSource.getUsers();
        if (localUsers.isNotEmpty) {
          _cachedUsers = localUsers;
          return localUsers;
        }
      }
      
      final cachedUsers = _cachedUsers;
      if (cachedUsers != null) {
        return cachedUsers;
      }
      
      rethrow;
    }
  }


  @override
  Future<void> refreshUsers() async {
    _cachedUsers = null;
    _lastFetchTime = null;
    await getUsers();
  }

  /// 캐시가 유효한지 확인
  bool _isCacheValid() {
    return CacheUtils.isCacheValid(_lastFetchTime, _cacheValidDuration);
  }
}

/// 사용자 원격 데이터 소스 인터페이스
abstract class UserRemoteDataSource {
  Future<List<User>> fetchUsers();
}

/// 사용자 로컬 데이터 소스 인터페이스
abstract class UserLocalDataSource {
  Future<List<User>> getUsers();
  Future<void> saveUsers(List<User> users);
  Future<void> clearUsers();
} 