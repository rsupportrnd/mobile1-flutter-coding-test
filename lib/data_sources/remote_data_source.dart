import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/room.dart';
import '../models/message.dart';
import '../repositories/user_repository.dart';
import '../repositories/room_repository.dart';
import '../repositories/message_repository.dart';
import '../config/app_constants.dart';
import '../utils/logger.dart';

/// 원격 데이터 소스 기본 클래스
abstract class BaseRemoteDataSource {
  final http.Client _client;

  BaseRemoteDataSource({http.Client? client}) 
      : _client = client ?? http.Client();

  /// GET 요청을 처리하는 공통 메서드
  Future<Map<String, dynamic>> performGetRequest(
    String url, 
    String operation,
    String errorMessage,
  ) async {
    final stopwatch = Logger.startTimer(operation);
    
    try {
      Logger.apiRequest('GET', url);
      final uri = Uri.parse(url);
      final response = await _client.get(uri).timeout(AppConstants.requestTimeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        Logger.apiResponse('GET', url, response.statusCode);
        Logger.endTimer(stopwatch, operation);
        return jsonResponse;
      } else {
        Logger.apiError('GET', url, response.statusCode, '서버 응답 오류');
        throw Exception('서버 응답 오류: ${response.statusCode}');
      }
    } catch (e) {
      Logger.endTimer(stopwatch, operation);
      
      if (e.toString().contains('TimeoutException')) {
        Logger.apiError('GET', url, null, '요청 시간 초과', error: e);
        throw Exception('${AppConstants.networkErrorMessage}: 요청 시간 초과');
      }
      
      Logger.apiError('GET', url, null, '$operation 실패', error: e);
      throw Exception('$errorMessage: $e');
    }
  }

  /// POST 요청을 처리하는 공통 메서드
  Future<http.Response> performPostRequest(
    String url,
    Map<String, dynamic> body,
    String operation,
    String errorMessage,
  ) async {
    final stopwatch = Logger.startTimer(operation);
    
    try {
      Logger.apiRequest('POST', url, body: body);
      final uri = Uri.parse(url);
      final response = await _client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      ).timeout(AppConstants.requestTimeout);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Logger.apiResponse('POST', url, response.statusCode);
        Logger.endTimer(stopwatch, operation);
        return response;
      } else {
        Logger.apiError('POST', url, response.statusCode, '$operation 실패');
        throw Exception('$operation 실패: ${response.statusCode}');
      }
    } catch (e) {
      Logger.endTimer(stopwatch, operation);
      
      if (e.toString().contains('TimeoutException')) {
        Logger.apiError('POST', url, null, '$operation 시간 초과', error: e);
        throw Exception('$operation 시간 초과');
      }
      
      Logger.apiError('POST', url, null, '$operation 실패', error: e);
      throw Exception('$errorMessage: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}

/// 사용자 원격 데이터 소스 구현체
class UserRemoteDataSourceImpl extends BaseRemoteDataSource 
    implements UserRemoteDataSource {

  UserRemoteDataSourceImpl({super.client});

  @override
  Future<List<User>> fetchUsers() async {
    final url = AppConstants.getUsersUrl();
    final jsonResponse = await performGetRequest(
      url, 
      '사용자 목록 조회',
      AppConstants.loadingUsersErrorMessage,
    );
    
    final List<dynamic> jsonData = jsonResponse['users'];
    final users = jsonData.map((json) => User.fromJson(json)).toList();
    
    Logger.info('사용자 ${users.length}명 조회 완료');
    return users;
  }
}

/// 회의실 원격 데이터 소스 구현체
class RoomRemoteDataSourceImpl extends BaseRemoteDataSource 
    implements RoomRemoteDataSource {

  RoomRemoteDataSourceImpl({super.client});

  @override
  Future<List<Room>> fetchRooms() async {
    final url = AppConstants.getRoomsUrl();
    final jsonResponse = await performGetRequest(
      url,
      '회의실 목록 조회',
      AppConstants.loadingRoomsErrorMessage,
    );
    
    final List<dynamic> jsonData = jsonResponse['chatRooms'];
    final rooms = jsonData.map((json) => Room.fromJson(json)).toList();
    
    Logger.info('회의실 ${rooms.length}개 조회 완료');
    return rooms;
  }
}

/// 메시지 원격 데이터 소스 구현체
class MessageRemoteDataSourceImpl extends BaseRemoteDataSource 
    implements MessageRemoteDataSource {

  MessageRemoteDataSourceImpl({super.client});

  @override
  Future<List<Message>> fetchMessages(String roomId) async {
    final url = AppConstants.getMessagesUrl();
    final jsonResponse = await performGetRequest(
      url,
      '메시지 목록 조회',
      AppConstants.loadingMessagesErrorMessage,
    );
    
    Logger.debug('메시지 조회 대상 룸: $roomId');
    
    final List<dynamic> jsonData = jsonResponse['messages'];
    final allMessages = jsonData.map((json) {
      // API 데이터 형태에 맞게 변환
      final messageJson = {
        'id': json['messageId'],
        'roomId': json['roomId'],
        'userId': json['sender'],
        'userName': null, // API에서 제공하지 않음
        'content': json['content'],
        'timestamp': json['timestamp'],
      };
      return Message.fromJson(messageJson);
    }).toList();
    
    // 특정 룸의 메시지만 필터링
    final filteredMessages = allMessages.where((message) => message.roomId == roomId).toList();
    
    Logger.info('룸 $roomId의 메시지 ${filteredMessages.length}개 조회 완료 (전체 ${allMessages.length}개 중)');
    return filteredMessages;
  }

  @override
  Future<void> sendMessage(Message message) async {
    final url = AppConstants.getMessagesUrl();
    final messageBody = {
      'messageId': message.id,
      'roomId': message.roomId,
      'sender': message.userId,
      'content': message.content,
      'timestamp': message.timestamp.toIso8601String(),
    };
    
    Logger.debug('전송할 메시지: ${message.content.length > 50 ? '${message.content.substring(0, 50)}...' : message.content}');
    
    await performPostRequest(
      url,
      messageBody,
      '메시지 전송',
      '메시지 전송 실패',
    );
    
    Logger.info('메시지 전송 성공: 룸 ${message.roomId}');
  }
}