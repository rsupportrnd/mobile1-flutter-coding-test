import 'package:mobile1_flutter_coding_test/data/model/message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room_model.freezed.dart';
part 'chat_room_model.g.dart';

@freezed
class ChatRoomListModel with _$ChatRoomListModel {
  factory ChatRoomListModel({
    required List<ChatRoomModel> chatRooms,
  }) = _ChatRoomListModel;

  factory ChatRoomListModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomListModelFromJson(json);
}

@freezed
class ChatRoomModel with _$ChatRoomModel {
  factory ChatRoomModel({
    required String roomId,
    required String roomName,
    required String creator,
    required List<String> participants,
    required String createdAt,
    MessageModel? lastMessage,
    required String thumbnailImage,
  }) = _ChatRoomModel;

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);
}
