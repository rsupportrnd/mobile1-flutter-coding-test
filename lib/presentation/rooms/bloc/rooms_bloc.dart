import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/core/injector.dart';
import 'package:mobile1_flutter_coding_test/models/room.dart';
import 'package:mobile1_flutter_coding_test/repository/message_repository.dart';
import 'package:mobile1_flutter_coding_test/repository/room_repository.dart';

part 'rooms_event.dart';
part 'rooms_state.dart';
part 'rooms_bloc.freezed.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  RoomsBloc()
    : _roomRepo = injector<RoomRepository>(),
      _msgRepo = injector<MessageRepository>(),
      super(const RoomsState()) {
    on<RoomsEvent>((event, emit) async {
      await event.when(
        load: () async {
          emit(state.copyWith(loading: true));
          try {
            await _roomRepo.load();
            final rooms = _filterAndSort(_roomRepo.rooms, state.currentUserId);
            emit(state.copyWith(loading: false, rooms: rooms));
            await _setupRoomSubscriptions(rooms, emit);
            await _recomputeUnreadAll(emit);
          } catch (e) {
            emit(state.copyWith(loading: false, error: e.toString()));
          }
        },
        setCurrentUser: (userId) async {
          final rooms = _filterAndSort(_roomRepo.rooms, userId);
          await _cancelAllSubs();
          emit(
            state.copyWith(
              currentUserId: userId,
              rooms: rooms,
              unreadByRoom: const {},
              unReadCount: 0,
            ),
          );
          await _setupRoomSubscriptions(rooms, emit);
          await _recomputeUnreadAll(emit);
        },
        updateLastMessage: (roomId, lastMessage) async {
          Room? updated;
          final others = <Room>[];
          for (final r in state.rooms) {
            if (r.roomId == roomId) {
              updated = r.copyWith(lastMessage: lastMessage);
            } else {
              others.add(r);
            }
          }
          if (updated != null) {
            final next = [updated, ...others];
            emit(state.copyWith(rooms: next));
            await _recomputeUnreadOnly(roomId, emit);
          }
        },
        refreshUnread: () async {
          await _recomputeUnreadAll(emit);
        },
        refreshUnreadOnly: (roomId) async {
          await _recomputeUnreadOnly(roomId, emit);
        },
      );
    });
  }

  final RoomRepository _roomRepo;
  final MessageRepository _msgRepo;

  final Map<String, StreamSubscription> _roomSubs = {};

  int ts(Room r) =>
      DateTime.tryParse(
        (r.lastMessage?['timestamp'] ?? r.createdAt ?? '') as String,
      )?.millisecondsSinceEpoch ??
      0;

  List<Room> _filterAndSort(List<Room> rooms, String userId) {
    final filtered = userId.isEmpty
        ? List<Room>.of(rooms)
        : rooms.where((r) => r.participants.contains(userId)).toList();
    filtered.sort((a, b) => ts(b).compareTo(ts(a)));
    return filtered;
  }

  Future<void> _setupRoomSubscriptions(
    List<Room> rooms,
    Emitter<RoomsState> emit,
  ) async {
    await _cancelAllSubs();
    final uid = state.currentUserId;
    if (uid.isEmpty) return;

    for (final r in rooms) {
      _roomSubs[r.roomId] = _msgRepo.watchByRoom(r.roomId).listen((_) async {
        // 해당 방만 증분 계산
        final c = await _msgRepo.unreadCount(roomId: r.roomId, userId: uid);
        final map = Map<String, int>.from(state.unreadByRoom)..[r.roomId] = c;
        final total = map.values.fold<int>(0, (a, b) => a + b);
        emit(state.copyWith(unreadByRoom: map, unReadCount: total));
      });
    }
  }

  Future<void> _recomputeUnreadAll(Emitter<RoomsState> emit) async {
    final uid = state.currentUserId;
    if (uid.isEmpty || state.rooms.isEmpty) {
      emit(state.copyWith(unreadByRoom: const {}, unReadCount: 0));
      return;
    }
    final entries = await Future.wait(
      state.rooms.map((r) async {
        final c = await _msgRepo.unreadCount(roomId: r.roomId, userId: uid);
        return MapEntry(r.roomId, c);
      }),
    );
    final map = Map<String, int>.fromEntries(entries);
    final total = map.values.fold<int>(0, (a, b) => a + b);
    emit(state.copyWith(unreadByRoom: map, unReadCount: total));
  }

  Future<void> _recomputeUnreadOnly(
    String roomId,
    Emitter<RoomsState> emit,
  ) async {
    final uid = state.currentUserId;
    if (uid.isEmpty) return;
    final count = await _msgRepo.unreadCount(roomId: roomId, userId: uid);
    final map = Map<String, int>.from(state.unreadByRoom)..[roomId] = count;
    final total = map.values.fold<int>(0, (a, b) => a + b);
    emit(state.copyWith(unreadByRoom: map, unReadCount: total));
  }

  Future<void> _cancelAllSubs() async {
    for (final s in _roomSubs.values) {
      await s.cancel();
    }
    _roomSubs.clear();
  }

  @override
  Future<void> close() async {
    await _cancelAllSubs();
    return super.close();
  }
}
