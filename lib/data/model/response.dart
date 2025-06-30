import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/data/model/message_model.dart';
import 'package:mobile1_flutter_coding_test/data/model/room_model.dart';
import 'package:mobile1_flutter_coding_test/data/model/user_model.dart';

part 'response.freezed.dart';
part 'response.g.dart';

@freezed
abstract class UsersResponse with _$UsersResponse {
  const factory UsersResponse({
    required List<UserModel> users,
  }) = _UsersResponse;

  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);
}

@freezed
abstract class ChatRoomResponse with _$ChatRoomResponse {
  const factory ChatRoomResponse({
    required List<ChatRoomModel> chatRooms,
  }) = _ChatRoomResponse;

  factory ChatRoomResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomResponseFromJson(json);
}

@freezed
abstract class MessageResponse with _$MessageResponse {
  const factory MessageResponse({
    required List<MessageModel> messages,
  }) = _MessageResponse;

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);
}
