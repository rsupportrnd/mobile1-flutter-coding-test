import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_list_response_entity.freezed.dart';
part 'message_list_response_entity.g.dart';

@freezed
class MessageListResponseEntity with _$MessageListResponseEntity {
  const factory MessageListResponseEntity({
    required List<MessageEntity> messages,
  }) = _MessageListResponseEntity;

  factory MessageListResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageListResponseEntityFromJson(json);
}

@freezed
class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    required String roomId,
    required String messageId,
    required String sender,
    required String content,
    required DateTime timestamp,
  }) = _MessageEntity;

  factory MessageEntity.fromJson(Map<String, dynamic> json) => _$MessageEntityFromJson(json);
}
