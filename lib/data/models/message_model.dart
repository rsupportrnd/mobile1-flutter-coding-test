/*
    {
      "roomId": "room1",
      "messageId": "msg1",
      "sender": "user1",
      "content": "안녕하세요, 오늘 회의 시작할까요?",
      "timestamp": "2024-11-07T10:00:00Z"
    },
*/

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
    required DateTime timestamp,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);
}
