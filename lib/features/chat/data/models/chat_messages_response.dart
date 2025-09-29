import 'package:freezed_annotation/freezed_annotation.dart';
import 'chat_message.dart';

part 'chat_messages_response.freezed.dart';
part 'chat_messages_response.g.dart';

@freezed
abstract class ChatMessagesResponse with _$ChatMessagesResponse {
  const factory ChatMessagesResponse({
    required List<ChatMessage> messages,
  }) = _ChatMessagesResponse;

  factory ChatMessagesResponse.fromJson(Map<String, dynamic> json) => _$ChatMessagesResponseFromJson(json);
}