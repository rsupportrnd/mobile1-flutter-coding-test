import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../config/app_constants.dart';
import '../utils/cache_utils.dart';
import '../utils/logger.dart';
import 'http_client.dart';

/// 사용자 원격 데이터 소스 인터페이스
abstract class UserRemoteDataSource {
  Future<List<User>> fetchUsers();
}

/// 사용자 로컬 데이터 소스 인터페이스
abstract class UserLocalDataSource {
  Future<List<User>> getUsers();
  Future<void> saveUsers(List<User> users);
  Future<void> clearUsers();
  Future<DateTime?> getLastUpdateTime();
}

/// 사용자 원격 데이터 소스 구현체
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final HttpClient _httpClient;

  UserRemoteDataSourceImpl({HttpClient? httpClient}) 
      : _httpClient = httpClient ?? HttpClient();

  @override
  Future<List<User>> fetchUsers() async {
    final url = AppConstants.getUsersUrl();
    
    try {
      final jsonResponse = await _httpClient.get(url);
      final List<dynamic> jsonData = jsonResponse['users'];
      final users = jsonData.map((json) => User.fromJson(json)).toList();
      
      Logger.info('사용자 ${users.length}명 조회 완료');
      return users;
    } catch (e) {
      Logger.error('사용자 목록 조회 실패', error: e);
      throw Exception('${AppConstants.loadingUsersErrorMessage}: $e');
    }
  }

  void dispose() {
    _httpClient.dispose();
  }
}

/// 사용자 로컬 데이터 소스 구현체
class UserLocalDataSourceImpl implements UserLocalDataSource {
  static const String _usersKey = AppConstants.cachedUsersKey;
  static const String _lastUpdateKey = AppConstants.usersLastUpdateKey;

  @override
  Future<List<User>> getUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getStringList(_usersKey) ?? [];
      final users = CacheUtils.jsonListToUsers(usersJson);
      
      Logger.cache('로드', _usersKey, hit: users.isNotEmpty);
      return users;
    } catch (e) {
      Logger.error('로컬 사용자 데이터 로드 실패', error: e);
      return [];
    }
  }

  @override
  Future<void> saveUsers(List<User> users) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = CacheUtils.usersToJsonList(users);
      
      await prefs.setStringList(_usersKey, usersJson);
      await prefs.setString(_lastUpdateKey, CacheUtils.dateTimeToString(DateTime.now()));
      
      Logger.cache('저장', _usersKey);
      Logger.info('사용자 ${users.length}명 로컬 저장 완료');
    } catch (e) {
      Logger.error('사용자 로컬 저장 실패', error: e);
    }
  }

  @override
  Future<void> clearUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_usersKey);
      await prefs.remove(_lastUpdateKey);
      
      Logger.cache('클리어', _usersKey);
    } catch (e) {
      Logger.error('사용자 캐시 클리어 실패', error: e);
    }
  }

  @override
  Future<DateTime?> getLastUpdateTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastUpdateStr = prefs.getString(_lastUpdateKey);
      return CacheUtils.stringToDateTime(lastUpdateStr);
    } catch (e) {
      Logger.error('마지막 업데이트 시간 가져오기 실패', error: e);
      return null;
    }
  }
} 