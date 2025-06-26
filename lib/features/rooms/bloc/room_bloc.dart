import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/room_repository.dart';
import 'room_event.dart';
import 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository roomRepository;

  RoomBloc({required this.roomRepository}) : super(RoomInitial()) {
    on<RoomLoadRequested>(_onRoomLoadRequested);
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
}
