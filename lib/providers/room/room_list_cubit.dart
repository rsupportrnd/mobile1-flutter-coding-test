import 'package:mobile1_flutter_coding_test/index.dart';

part 'room_list_state.dart';

part 'room_list_cubit.freezed.dart';

@injectable
class RoomListCubit extends Cubit<RoomListState> {
  final RoomService _roomService;

  RoomListCubit(this._roomService) : super(const RoomListState.initial());

  Future<void> fetchRooms() async {
    emit(const RoomListState.loading());
    try {
      List<RoomModel> response = await _roomService.fetchRooms();
      emit(RoomListState.loaded(response));
    } catch (e) {
      emit(RoomListState.error(e.toString()));
    }
  }

  String convertFormatTimeDiff(String timestamp) {
    return _roomService.convertFormatTimeDiff(timestamp);
  }
}
