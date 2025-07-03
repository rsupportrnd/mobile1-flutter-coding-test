import 'package:mobile1_flutter_coding_test/common/network/custom_exceptions.dart';
import 'package:mobile1_flutter_coding_test/common/viewmodel/base_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/common/viewmodel/viewmodel_state.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/room_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_rooms_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/post_room_message_usecase.dart';

class RoomListViewModel extends BaseViewModel {
  final GetRoomsUseCase getRoomsUseCase;
  final PostRoomMessageUseCase postRoomMessageUseCase;
  ViewModelState<List<RoomEntity>> _rooms = ViewModelState.loading();
  ViewModelState<List<RoomEntity>> get roomsState => _rooms;

  RoomListViewModel({
    required this.getRoomsUseCase,
    required this.postRoomMessageUseCase,
  }) {
    fetchRooms();
    register<MessageEntity>(postRoomMessageUseCase.stream, listener: postMessageListener);
  }

  void setRooms(ViewModelState<List<RoomEntity>> state) {
    _rooms = state;
    notifyListeners();
  }

  void fetchRooms() async {
    try {
      setRooms(ViewModelState.success(data: await getRoomsUseCase.call()));
    } on NetworkException catch (e) {
      setRooms(ViewModelState.error(error: e.message));
    } on UnknownException catch (e) {
      setRooms(ViewModelState.error(error: e.message));
    } catch (e) {
      setRooms(ViewModelState.error(error: e.toString()));
    }
  }

  void postMessageListener(MessageEntity event) {
    final state = roomsState;
    if (state is! ViewModelStateSuccess<List<RoomEntity>>) {
      return;
    }

    final newRooms = state.data.map((room) {
      if (room.roomId == event.roomId) {
        return room.copyWith(
            lastMessage: LastMessageEntity(
          sender: event.sender,
          content: event.content,
          timestamp: event.timestamp,
        ));
      }
      return room;
    }).toList();
    setRooms(ViewModelState.success(data: newRooms));
  }
}
