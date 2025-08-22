part of 'rooms_bloc.dart';

@freezed
class RoomsEvent with _$RoomsEvent {
  const factory RoomsEvent.load() = _Load;
  const factory RoomsEvent.setCurrentUser(String userId) = _SetCurrentUser;
  const factory RoomsEvent.updateLastMessage(
    String roomId,
    Map<String, dynamic> lastMessage,
  ) = _UpdateLastMessage;
  const factory RoomsEvent.refreshUnread() = _RefreshUnread;
  const factory RoomsEvent.refreshUnreadOnly(String roomId) =
      _RefreshUnreadOnly;
}
