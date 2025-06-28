import 'package:mobile1_flutter_coding_test/app/index.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository roomRepository;

  RoomBloc({required this.roomRepository}) : super(RoomInitial()) {
    on<RoomLoadRequested>(_onRoomLoadRequested);
    on<RoomLastMessageUpdated>(_onRoomLastMessageUpdated);
  }

  Future<void> _onRoomLoadRequested(
      RoomLoadRequested event,
      Emitter<RoomState> emit,
      ) async {
    emit(RoomLoadInProgress());

    try {
      final rooms = await roomRepository.fetchRooms();
      emit(RoomLoadSuccess(rooms));
    } catch (e) {
      emit(RoomLoadFailure(e.toString()));
    }
  }

  void _onRoomLastMessageUpdated(
      RoomLastMessageUpdated event,
      Emitter<RoomState> emit,
      ) async {
    if (state is RoomLoadSuccess) {
      final currentState = state as RoomLoadSuccess;

      final updatedRooms = currentState.rooms.map((room) {
        if (room.roomId == event.roomId) {
          return room.copyWith(lastMessage: event.lastMessage);
        }
        return room;
      }).toList();

      // timestamp 기준으로 내림차순 정렬
      updatedRooms.sort((a, b) => b.lastMessage.timestamp.compareTo(a.lastMessage.timestamp));

      emit(RoomLoadSuccess(updatedRooms));

      // 여기서 로컬 DB에 lastMessage 저장 (비동기 작업)
      try {
        await roomRepository.saveLastMessage(event.roomId, event.lastMessage);
      } catch (e) {
      }
    }
  }
}
