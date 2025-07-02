import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_model.freezed.dart';
part 'room_model.g.dart';

@freezed
abstract class ChatRoomModel with _$ChatRoomModel {
  const factory ChatRoomModel({
    required String roomId,
    required String roomName,
    required String creator,
    required List<String> participants,
    required String createdAt,
    required LastMessageModel lastMessage,
    required String thumbnailImage,
  }) = _ChatRoomModel;

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);
}

@freezed
abstract class LastMessageModel with _$LastMessageModel {
  const factory LastMessageModel({
    required String sender,
    required String content,
    required String timestamp,
  }) = _LastMessageModel;

  factory LastMessageModel.fromJson(Map<String, dynamic> json) =>
      _$LastMessageModelFromJson(json);
}
