import 'package:flutter_bloc/flutter_bloc.dart';
import '../../rooms/bloc/room_bloc.dart';
import '../../rooms/bloc/room_event.dart';
import '../../rooms/data/models/room.dart';
import 'message_event.dart';
import 'message_state.dart';
import '../data/repositories/message_repository.dart';
import '../data/models/message.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;
  final RoomBloc roomBloc;

  MessageBloc({
    required this.messageRepository,
    required this.roomBloc,
  }) : super(MessageInitial()) {
    on<MessageLoadRequested>(_onMessageLoadRequested);
    on<MessageSent>(_onMessageSent);
  }

  Future<void> _onMessageLoadRequested(
    MessageLoadRequested event,
    Emitter<MessageState> emit,
  ) async {
    emit(MessageLoadInProgress());

    try {
      final remoteMessages = await messageRepository.fetchMessages();
      final localMessages = await messageRepository.getLocalMessagesByRoom(event.roomId);

      final apiMessages = remoteMessages.where((msg) => msg.roomId == event.roomId).toList();

      final allMessages = [...apiMessages, ...localMessages]..sort((a, b) => a.timestamp.compareTo(b.timestamp));

      emit(MessageLoadSuccess(allMessages));
    } catch (e) {
      emit(MessageLoadFailure('메시지를 불러오지 못했습니다.'));
    }
  }

  Future<void> _onMessageSent(
    MessageSent event,
    Emitter<MessageState> emit,
  ) async {
    if (state is! MessageLoadSuccess) return;

    final currentState = state as MessageLoadSuccess;
    final messages = List<Message>.from(currentState.messages);

    // 마지막 메시지 ID에서 숫자 추출
    final lastId = messages.map((msg) {
      final num = int.tryParse(msg.messageId.replaceAll(RegExp(r'[^0-9]'), ''));
      return num ?? 0;
    }).fold<int>(0, (prev, curr) => curr > prev ? curr : prev);

    final newMessage = Message(
      roomId: event.roomId,
      messageId: 'msg${lastId + 1}',
      sender: 'user99',
      content: event.content,
      timestamp: DateTime.now().toUtc(),
    );

    // 로컬 DB에 메시지 저장
    await messageRepository.saveMessage(newMessage);

    // RoomBloc에도 최신 메시지 정보 업데이트
    roomBloc.add(
      RoomLastMessageUpdated(
        roomId: newMessage.roomId,
        lastMessage: LastMessage(
          sender: newMessage.sender,
          content: newMessage.content,
          timestamp: newMessage.timestamp,
        ),
      ),
    );

    // 화면에 반영
    messages.add(newMessage);
    emit(MessageLoadSuccess(messages));
  }
}
