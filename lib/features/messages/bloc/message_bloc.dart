// message_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'message_event.dart';
import 'message_state.dart';
import '../data/repositories/message_repository.dart';
import '../data/models/message.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;

  MessageBloc({required this.messageRepository}) : super(MessageInitial()) {
    on<MessageLoadRequested>(_onMessageLoadRequested);
    on<MessageSent>(_onMessageSent);
  }

  Future<void> _onMessageLoadRequested(
    MessageLoadRequested event,
    Emitter<MessageState> emit,
  ) async {
    emit(MessageLoadInProgress());
    try {
      final allMessages = await messageRepository.fetchMessages();
      final filtered = allMessages.where((message) => message.roomId == event.roomId).toList();
      emit(MessageLoadSuccess(filtered));
    } catch (e) {
      emit(MessageLoadFailure('메시지를 불러오지 못했습니다.'));
    }
  }

  Future<void> _onMessageSent(
    MessageSent event,
    Emitter<MessageState> emit,
  ) async {
    if (state is MessageLoadSuccess) {
      final currentState = state as MessageLoadSuccess;
      final messages = List<Message>.from(currentState.messages);

      // 새로운 메시지 ID 생성
      int lastId = 0;
      if (messages.isNotEmpty) {
        final last = messages.last.messageId;
        final number = int.tryParse(last.replaceAll(RegExp(r'[^0-9]'), ''));
        lastId = number ?? 0;
      }
      final newMessageId = 'msg${lastId + 1}';

      final newMessage = Message(
        roomId: event.roomId,
        messageId: newMessageId,
        sender: 'user99',
        content: event.content,
        timestamp: DateTime.now().toUtc(),
      );

      messages.add(newMessage);

      emit(MessageLoadSuccess(messages));
    }
  }
}
