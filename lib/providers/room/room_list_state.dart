part of 'room_list_cubit.dart';

@freezed
class RoomListState with _$RoomListState {
  const factory RoomListState.initial() = _Initial;
  const factory RoomListState.loading() = _Loading;
  const factory RoomListState.loaded(List<RoomModel> roomList) = _Loaded;
  const factory RoomListState.error(String message) = _Error;
}
