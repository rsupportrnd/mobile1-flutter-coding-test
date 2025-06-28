import 'package:shared_preferences/shared_preferences.dart';
import '../models/room.dart';
import '../config/app_constants.dart';
import '../utils/cache_utils.dart';
import '../utils/logger.dart';
import 'http_client.dart';

abstract class RoomRemoteDataSource {
  Future<List<Room>> fetchRooms();
}

abstract class RoomLocalDataSource {
  Future<List<Room>> getRooms();
  Future<void> saveRooms(List<Room> rooms);
  Future<void> clearRooms();
  Future<DateTime?> getLastUpdateTime();
}

class RoomRemoteDataSourceImpl implements RoomRemoteDataSource {
  final HttpClient _httpClient;

  RoomRemoteDataSourceImpl({HttpClient? httpClient}) 
      : _httpClient = httpClient ?? HttpClient();

  @override
  Future<List<Room>> fetchRooms() async {
    final url = AppConstants.getRoomsUrl();
    
    try {
      final jsonResponse = await _httpClient.get(url);
      final List<dynamic> jsonData = jsonResponse['chatRooms'];
      final rooms = jsonData.map((json) => Room.fromJson(json)).toList();
      
      Logger.info('룸 ${rooms.length}개 조회 완료');
      return rooms;
    } catch (e) {
      Logger.error('룸 목록 조회 실패', error: e);
      throw Exception('${AppConstants.loadingRoomsErrorMessage}: $e');
    }
  }

  void dispose() {
    _httpClient.dispose();
  }
}

class RoomLocalDataSourceImpl implements RoomLocalDataSource {
  static const String _roomsKey = AppConstants.cachedRoomsKey;
  static const String _lastUpdateKey = AppConstants.roomsLastUpdateKey;

  @override
  Future<List<Room>> getRooms() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final roomsJson = prefs.getStringList(_roomsKey) ?? [];
      final rooms = CacheUtils.jsonListToRooms(roomsJson);
      
      Logger.cache('로드', _roomsKey, hit: rooms.isNotEmpty);
      return rooms;
    } catch (e) {
      Logger.error('로컬 룸 데이터 로드 실패', error: e);
      return [];
    }
  }

  @override
  Future<void> saveRooms(List<Room> rooms) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final roomsJson = CacheUtils.roomsToJsonList(rooms);
      
      await prefs.setStringList(_roomsKey, roomsJson);
      await prefs.setString(_lastUpdateKey, CacheUtils.dateTimeToString(DateTime.now()));
      
      Logger.cache('저장', _roomsKey);
      Logger.info('룸 ${rooms.length}개 로컬 저장 완료');
    } catch (e) {
      Logger.error('룸 로컬 저장 실패', error: e);
    }
  }

  @override
  Future<void> clearRooms() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_roomsKey);
      await prefs.remove(_lastUpdateKey);
      
      Logger.cache('클리어', _roomsKey);
    } catch (e) {
      Logger.error('룸 캐시 클리어 실패', error: e);
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