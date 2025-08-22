part of 'chat_bloc.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    @Default(false) bool loading,
    @Default([]) List<ChatMessage> messages,
    Room? room,
    @Default('') String currentUserId,
    String? error,
    @Default({}) Map<String, AppUser> userById,
  }) = _ChatState;
}
