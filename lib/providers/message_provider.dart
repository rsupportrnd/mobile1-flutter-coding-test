import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/message.dart';
import '../repositories/message_repository.dart';
import '../providers/repository_providers.dart';

class MessageQueryParams {
  final String roomId;
  final int count;

  const MessageQueryParams({
    required this.roomId,
    required this.count,
  });
}

// 메시지 프로바이더
final messagesProvider = FutureProvider.family<List<Message>, String>((ref, roomId) async {
  final messageRepository = ref.watch(messageRepositoryProvider);
  return await messageRepository.getMessages(roomId);
});

// 날짜별 메시지 프로바이더
final messagesByDateProvider = FutureProvider.family<Map<String, List<Message>>, String>((ref, roomId) async {
  final messageRepository = ref.watch(messageRepositoryProvider);
  return await messageRepository.getMessagesByDate(roomId);
});

// 최근 메시지 프로바이더
final recentMessagesProvider = FutureProvider.family<List<Message>, MessageQueryParams>((ref, params) async {
  final messageRepository = ref.watch(messageRepositoryProvider);
  return await messageRepository.getRecentMessages(params.roomId, params.count);
});

// 메시지 전송 상태
class MessageSendState {
  final bool isSending;
  final String? error;
  final Message? lastSentMessage;

  const MessageSendState({
    this.isSending = false,
    this.error,
    this.lastSentMessage,
  });

  MessageSendState copyWith({
    bool? isSending,
    String? error,
    Message? lastSentMessage,
  }) {
    return MessageSendState(
      isSending: isSending ?? this.isSending,
      error: error ?? this.error,
      lastSentMessage: lastSentMessage ?? this.lastSentMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MessageSendState &&
              runtimeType == other.runtimeType &&
              isSending == other.isSending &&
              error == other.error &&
              lastSentMessage == other.lastSentMessage;

  @override
  int get hashCode => isSending.hashCode ^ error.hashCode ^ lastSentMessage.hashCode;
}

// 메시지 전송 처리 클래스
class MessageNotifier extends StateNotifier<MessageSendState> {
  final MessageRepository _messageRepository;
  final Ref _ref;

  MessageNotifier(this._messageRepository, this._ref) : super(const MessageSendState());

  Future<void> sendMessage({
    required String roomId,
    required String userId,
    required String userName,
    required String content,
  }) async {
    if (content.trim().isEmpty) {
      state = state.copyWith(error: '메시지 내용을 입력해주세요');
      return;
    }

    state = state.copyWith(isSending: true, error: null);

    try {
      final message = Message(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        roomId: roomId,
        userId: userId,
        userName: userName,
        content: content.trim(),
        timestamp: DateTime.now(),
      );

      // Repository를 통해 메시지 전송
      await _messageRepository.sendMessage(message);

      // 관련 Provider들 새로고침
      _ref.invalidate(messagesProvider(roomId));
      _ref.invalidate(messagesByDateProvider(roomId));

      final recentMessageParams = MessageQueryParams(roomId: roomId, count: 1);
      _ref.invalidate(recentMessagesProvider(recentMessageParams));

      state = state.copyWith(
        isSending: false,
        lastSentMessage: message,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isSending: false,
        error: '메시지 전송에 실패했습니다: ${e.toString()}',
      );
    }
  }
}

// 메시지 전송 프로바이더 (Repository 기반)
final messageNotifierProvider = StateNotifierProvider<MessageNotifier, MessageSendState>((ref) {
  final messageRepository = ref.watch(messageRepositoryProvider);
  return MessageNotifier(messageRepository, ref);
});