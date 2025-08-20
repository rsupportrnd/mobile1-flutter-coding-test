part of 'rooms_bloc.dart';

@freezed
class RoomsState with _$RoomsState {
  const factory RoomsState({
    @Default(false) bool loading,
    @Default([]) List<Room> rooms,
    @Default('') String currentUserId,
    String? error,
  }) = _RoomsState;
}
