import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/core/injector.dart';
import 'package:mobile1_flutter_coding_test/models/room.dart';
import 'package:mobile1_flutter_coding_test/repository/room_repository.dart';

part 'rooms_event.dart';
part 'rooms_state.dart';
part 'rooms_bloc.freezed.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  RoomsBloc() : super(const RoomsState()) {
    on<RoomsEvent>((event, emit) async {
      await event.when(
        load: () async {
          emit(state.copyWith(loading: true));
          try {
            final repo = injector<RoomRepository>();
            await repo.load();
            final rooms = repo.rooms;
            final filtered = state.currentUserId.isEmpty
                ? rooms
                : rooms
                      .where(
                        (r) => r.participants.contains(state.currentUserId),
                      )
                      .toList();
            emit(state.copyWith(loading: false, rooms: filtered));
          } catch (e) {
            emit(state.copyWith(loading: false, error: e.toString()));
          }
        },
        setCurrentUser: (userId) async {
          // 세션 변경 반영 후 재필터
          final repo = injector<RoomRepository>();
          await repo.load();
          final rooms = repo.rooms;
          final filtered = userId.isEmpty
              ? rooms
              : rooms.where((r) => r.participants.contains(userId)).toList();
          emit(state.copyWith(currentUserId: userId, rooms: filtered));
        },
      );
    });
  }
}
