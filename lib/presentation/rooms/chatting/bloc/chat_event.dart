part of 'chat_bloc.dart';

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.load(String roomId) = _Load;
  const factory ChatEvent.send(String content, String senderId) = _Send;
  const factory ChatEvent.messagesUpdated(List<ChatMessage> messages) =
      _MessagesUpdated;
}
