import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/message.dart';
import '../utils/logger.dart';
import 'repository_providers.dart';

// 메시지 목록 상태 관리

class MessagesState {
  final Map<String, List<Message>> messagesByRoom;
  final Map<String, bool> loadingByRoom;
  final Map<String, String?> errorsByRoom;
  final String searchQuery;

  MessagesState({
    this.messagesByRoom = const {},
    this.loadingByRoom = const {},
    this.errorsByRoom = const {},
    this.searchQuery = '',
  });

  MessagesState copyWith({
    Map<String, List<Message>>? messagesByRoom,
    Map<String, bool>? loadingByRoom,
    Map<String, String?>? errorsByRoom,
    String? searchQuery,
  }) {
    return MessagesState(
      messagesByRoom: messagesByRoom ?? this.messagesByRoom,
      loadingByRoom: loadingByRoom ?? this.loadingByRoom,
      errorsByRoom: errorsByRoom ?? this.errorsByRoom,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<Message> getMessagesForRoom(String roomId) {
    return messagesByRoom[roomId] ?? [];
  }

  bool isLoadingForRoom(String roomId) {
    return loadingByRoom[roomId] ?? false;
  }

  String? getErrorForRoom(String roomId) {
    return errorsByRoom[roomId];
  }

  List<Message> getFilteredMessages(String roomId) {
    final messages = getMessagesForRoom(roomId);
    
    if (searchQuery.isEmpty) return messages;
    
    final query = searchQuery.toLowerCase();
    return messages.where((message) {
      return message.content.toLowerCase().contains(query) ||
             (message.userName?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  Map<String, List<Message>> getMessagesByDate(String roomId) {
    final messages = getMessagesForRoom(roomId);
    final Map<String, List<Message>> grouped = {};
    
    for (final message in messages) {
      final dateKey = _formatDateKey(message.timestamp);
      grouped.putIfAbsent(dateKey, () => []).add(message);
    }
    
    return grouped;
  }

  String _formatDateKey(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);
    
    final difference = today.difference(messageDate).inDays;
    
    if (difference == 0) {
      return '오늘';
    } else if (difference == 1) {
      return '어제';
    } else if (difference < 7) {
      return '$difference일 전';
    } else {
      return '${date.year}년 ${date.month}월 ${date.day}일';
    }
  }
}

class MessagesNotifier extends StateNotifier<MessagesState> {
  final MessageRepository _messageRepository;

  MessagesNotifier(this._messageRepository) : super(MessagesState());

  Future<void> loadMessages(String roomId) async {
    state = state.copyWith(
      loadingByRoom: {...state.loadingByRoom, roomId: true},
      errorsByRoom: {...state.errorsByRoom, roomId: null},
    );
    
    try {
      Logger.info('룸 $roomId 메시지 로드 시작');
      final messages = await _messageRepository.getMessages(roomId);
      
      state = state.copyWith(
        messagesByRoom: {...state.messagesByRoom, roomId: messages},
        loadingByRoom: {...state.loadingByRoom, roomId: false},
      );
      
      Logger.info('룸 $roomId 메시지 로드 완료: ${messages.length}개');
    } catch (e) {
      Logger.error('룸 $roomId 메시지 로드 실패', error: e);
      
      state = state.copyWith(
        loadingByRoom: {...state.loadingByRoom, roomId: false},
        errorsByRoom: {...state.errorsByRoom, roomId: e.toString()},
      );
    }
  }

  void searchMessages(String query) {
    state = state.copyWith(searchQuery: query);
    Logger.debug('메시지 검색: "$query"');
  }

  Future<void> refreshMessages(String roomId) async {
    Logger.info('룸 $roomId 메시지 새로고침');
    await _messageRepository.refreshMessages(roomId);
    await loadMessages(roomId);
  }

  void addMessage(String roomId, Message message) {
    final currentMessages = state.getMessagesForRoom(roomId);
    final updatedMessages = [...currentMessages, message];
    updatedMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    
    state = state.copyWith(
      messagesByRoom: {...state.messagesByRoom, roomId: updatedMessages},
    );
    
    Logger.debug('룸 $roomId에 새 메시지 추가: ${message.content.length > 30 ? '${message.content.substring(0, 30)}...' : message.content}');
  }
}

// 메시지 전송 상태 관리

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
      error: error,
      lastSentMessage: lastSentMessage ?? this.lastSentMessage,
    );
  }
}

/// 메시지 전송 관리 Notifier
class MessageSendNotifier extends StateNotifier<MessageSendState> {
  final MessageRepository _messageRepository;
  final Ref _ref;

  MessageSendNotifier(this._messageRepository, this._ref) : super(const MessageSendState());

  /// 메시지 전송
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

      Logger.info('메시지 전송 시작: 룸 $roomId');
      
      _ref.read(messagesProvider.notifier).addMessage(roomId, message);
      
      await _messageRepository.sendMessage(message);
      
      state = state.copyWith(
        isSending: false,
        lastSentMessage: message,
        error: null,
      );
      
      Logger.info('메시지 전송 완료: 룸 $roomId');
    } catch (e) {
      Logger.error('메시지 전송 실패', error: e);
      
      state = state.copyWith(
        isSending: false,
        error: '메시지 전송에 실패했습니다: ${e.toString()}',
      );
    }
  }

  /// 에러 클리어
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider 정의

/// 메시지 목록 Provider
final messagesProvider = StateNotifierProvider<MessagesNotifier, MessagesState>((ref) {
  final messageRepository = ref.watch(messageRepositoryProvider);
  return MessagesNotifier(messageRepository);
});

/// 메시지 전송 Provider
final messageSendProvider = StateNotifierProvider<MessageSendNotifier, MessageSendState>((ref) {
  final messageRepository = ref.watch(messageRepositoryProvider);
  return MessageSendNotifier(messageRepository, ref);
});


final roomMessagesProvider = Provider.family<List<Message>, String>((ref, roomId) {
  return ref.watch(messagesProvider).getMessagesForRoom(roomId);
});

final filteredRoomMessagesProvider = Provider.family<List<Message>, String>((ref, roomId) {
  return ref.watch(messagesProvider).getFilteredMessages(roomId);
});

final roomMessagesByDateProvider = Provider.family<Map<String, List<Message>>, String>((ref, roomId) {
  return ref.watch(messagesProvider).getMessagesByDate(roomId);
});

final roomMessagesLoadingProvider = Provider.family<bool, String>((ref, roomId) {
  return ref.watch(messagesProvider).isLoadingForRoom(roomId);
});

final roomMessagesErrorProvider = Provider.family<String?, String>((ref, roomId) {
  return ref.watch(messagesProvider).getErrorForRoom(roomId);
});

final isMessageSendingProvider = Provider<bool>((ref) {
  return ref.watch(messageSendProvider).isSending;
});

final messageSendErrorProvider = Provider<String?>((ref) {
  return ref.watch(messageSendProvider).error;
});

final lastSentMessageProvider = Provider<Message?>((ref) {
  return ref.watch(messageSendProvider).lastSentMessage;
}); 