import 'package:freezed_annotation/freezed_annotation.dart';
import 'chat_room.dart';

part 'chat_room_list_response.freezed.dart';
part 'chat_room_list_response.g.dart';

@freezed
abstract class ChatRoomListResponse with _$ChatRoomListResponse {
  const factory ChatRoomListResponse({
    required List<ChatRoom> chatRooms,
  }) = _ChatRoomListResponse;

  factory ChatRoomListResponse.fromJson(Map<String, dynamic> json) => _$ChatRoomListResponseFromJson(json);
}