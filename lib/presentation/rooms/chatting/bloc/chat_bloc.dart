import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/core/injector.dart';
import 'package:mobile1_flutter_coding_test/models/app_user.dart';
import 'package:mobile1_flutter_coding_test/models/chat_message.dart';
import 'package:mobile1_flutter_coding_test/models/room.dart';
import 'package:mobile1_flutter_coding_test/presentation/rooms/bloc/rooms_bloc.dart';
import 'package:mobile1_flutter_coding_test/repository/message_repository.dart';
import 'package:mobile1_flutter_coding_test/repository/room_repository.dart';
import 'package:mobile1_flutter_coding_test/repository/user_repositoy.dart';

part 'chat_event.dart';
part 'chat_state.dart';
part 'chat_bloc.freezed.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(RoomsBloc rBloc)
    : _msgRepo = injector<MessageRepository>(),
      _roomRepo = injector<RoomRepository>(),
      _userRepo = injector<UserRepository>(),
      _rBloc = rBloc,
      super(const ChatState()) {
    on<ChatEvent>((event, emit) async {
      await event.when(
        load: (roomId) async {
          emit(state.copyWith(loading: true));
          try {
            await _roomRepo.load();
            await _msgRepo.load();
            await _ensureUsers();
            await _msgRepo.markRead(
              roomId: roomId,
              userId: rBloc.state.currentUserId,
              at: DateTime.now(),
            );
            rBloc.add(RoomsEvent.refreshUnreadOnly(roomId));
            final room = _roomRepo.getById(roomId);
            final initial = _msgRepo.messagesOf(roomId);
            emit(
              state.copyWith(
                loading: false,
                messages: initial,
                room: room,
                currentUserId: rBloc.state.currentUserId,
                userById: _usersToMap(_userRepo.users),
              ),
            );
            _startWatching(roomId);
          } catch (e) {
            emit(state.copyWith(loading: false, error: e.toString()));
          }
        },
        send: (content, senderId) async {
          if (content.trim().isEmpty || state.room == null) return;
          final now = DateTime.now();
          final msg = ChatMessage(
            roomId: state.room!.roomId,
            messageId: now.microsecondsSinceEpoch.toString(),
            sender: senderId,
            content: content.trim(),
            timestamp: now.toIso8601String(),
          );
          await _msgRepo.add(msg);
          _rBloc.add(
            RoomsEvent.updateLastMessage(state.room!.roomId, {
              'sender': senderId,
              'content': content.trim(),
              'timestamp': now.toIso8601String(),
            }),
          );
        },
        messagesUpdated: (messages) async {
          emit(state.copyWith(messages: messages));
        },
        onExit: (ack) async {
          await _sub?.cancel();

          final roomId = state.room?.roomId;
          final me = state.currentUserId;
          if (roomId != null && (me.isNotEmpty)) {
            await _msgRepo.markRead(
              roomId: roomId,
              userId: me,
              at: DateTime.now(),
            );
            rBloc.add(RoomsEvent.refreshUnreadOnly(roomId));
          }
          ack?.complete();
        },
      );
    });
  }

  final MessageRepository _msgRepo;
  final RoomRepository _roomRepo;
  final UserRepository _userRepo;
  final RoomsBloc _rBloc;
  StreamSubscription<List<ChatMessage>>? _sub;

  void _startWatching(String roomId) {
    // repo 구독
    _sub?.cancel();
    _sub = _msgRepo.watchByRoom(roomId).listen((msgs) {
      add(ChatEvent.messagesUpdated(msgs));
    });
  }

  Future<void> _ensureUsers() async {
    if (_userRepo.users.isEmpty) {
      await _userRepo.load();
    }
  }

  Map<String, AppUser> _usersToMap(List<AppUser> users) => {
    for (final u in users) u.userId: u,
  };

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
