part of 'rooms_bloc.dart';

@freezed
class RoomsState with _$RoomsState {
  const factory RoomsState({
    @Default(false) bool loading,
    @Default([]) List<Room> rooms,
    @Default('') String currentUserId,
    @Default({}) Map<String, int> unreadByRoom,
    @Default(0) int unReadCount,
    String? error,
  }) = _RoomsState;
}
