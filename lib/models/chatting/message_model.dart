

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String roomId,
    required String messageId,
    required String sender,
    required String content,
    required String timestamp,
  }) = _MessageModel;


  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  factory MessageModel.fromMessageEntity(messageEntity) =>
      MessageModel(
        roomId: messageEntity.roomId,
        messageId: messageEntity.messageId,
        sender: messageEntity.sender,
        content: messageEntity.content,
        timestamp: messageEntity.timestamp.toString(),
      );
}