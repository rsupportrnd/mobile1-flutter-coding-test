import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/chat_room_list_response.dart';
import '../models/chat_messages_response.dart';

part 'chat_api_service.g.dart';

@RestApi()
abstract class ChatApiService {
  factory ChatApiService(Dio dio, {String baseUrl}) = _ChatApiService;

  @GET('/rooms.json')
  Future<ChatRoomListResponse> getChatRooms();

  @GET('/messages.json')
  Future<ChatMessagesResponse> getMessages();
}