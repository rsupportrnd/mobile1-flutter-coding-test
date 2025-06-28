import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/message.dart';
import '../models/room.dart';
import '../providers/repository_providers.dart';
import '../config/app_constants.dart';

// 채팅 상태 관리
class ChatState {
  final List<Message> messages;
  final bool isLoading;
  final String? error;
  final Room? currentRoom;
  final String newMessageText;
  final bool isSending;
  final String? replyToMessageId;

  ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
    this.currentRoom,
    this.newMessageText = '',
    this.isSending = false,
    this.replyToMessageId,
  });

  ChatState copyWith({
    List<Message>? messages,
    bool? isLoading,
    String? error,
    Room? currentRoom,
    String? newMessageText,
    bool? isSending,
    String? replyToMessageId,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentRoom: currentRoom ?? this.currentRoom,
      newMessageText: newMessageText ?? this.newMessageText,
      isSending: isSending ?? this.isSending,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
    );
  }

  // 메시지를 날짜별로 그룹핑
  Map<String, List<Message>> get messagesByDate {
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

  // 메시지 전송 가능 여부
  bool get canSendMessage {
    return newMessageText.trim().isNotEmpty && 
           !isSending && 
           newMessageText.length <= AppConstants.maxMessageLength;
  }
}

// ChatViewModel - 채팅 관련 비즈니스 로직 처리
class ChatViewModel extends StateNotifier<ChatState> {
  final Ref _ref;
  
  ChatViewModel(this._ref) : super(ChatState());

  // 채팅방 설정
  void setRoom(Room room) {
    state = state.copyWith(currentRoom: room);
    loadMessages(room.id);
  }

  // 메시지 목록 로드
  Future<void> loadMessages(String roomId) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final messageRepository = _ref.read(messageRepositoryProvider);
      final messages = await messageRepository.getMessages(roomId);
      // 시간순으로 정렬
      messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      
      state = state.copyWith(
        messages: messages,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppConstants.loadingMessagesErrorMessage,
      );
    }
  }

  // 메시지 새로고침
  Future<void> refreshMessages() async {
    if (state.currentRoom != null) {
      await loadMessages(state.currentRoom!.id);
    }
  }

  // 새 메시지 텍스트 설정
  void setNewMessageText(String text) {
    state = state.copyWith(newMessageText: text);
  }

  // 메시지 전송 (실제로는 Mock - 실제 구현에서는 API 호출)
  Future<void> sendMessage(String userId) async {
    if (!state.canSendMessage || state.currentRoom == null) return;

    final messageText = state.newMessageText.trim();
    state = state.copyWith(isSending: true);

    try {
      // Mock message 생성 (실제로는 API 호출)
      final newMessage = Message(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        roomId: state.currentRoom!.id,
        userId: userId,
        userName: null, // 실제로는 사용자 이름을 가져와야 함
        content: messageText,
        timestamp: DateTime.now(),

      );

      // 메시지 목록에 추가
      final updatedMessages = [...state.messages, newMessage];
      
      state = state.copyWith(
        messages: updatedMessages,
        newMessageText: '',
        isSending: false,
        replyToMessageId: null,
      );
    } catch (e) {
      state = state.copyWith(
        isSending: false,
        error: '메시지 전송에 실패했습니다',
      );
    }
  }

  // 답장할 메시지 설정
  void setReplyToMessage(String messageId) {
    state = state.copyWith(replyToMessageId: messageId);
  }

  // 답장 취소
  void clearReplyToMessage() {
    state = state.copyWith(replyToMessageId: null);
  }

  // 메시지 입력 초기화
  void clearNewMessageText() {
    state = state.copyWith(newMessageText: '');
  }

  // 특정 사용자의 메시지 필터
  List<Message> getMessagesByUser(String userId) {
    return state.messages.where((message) => message.userId == userId).toList();
  }

  // 메시지 검색
  List<Message> searchMessages(String query) {
    if (query.isEmpty) return state.messages;
    
    return state.messages.where((message) {
      return message.content.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // 최근 메시지 (지정한 개수만큼)
  List<Message> getRecentMessages(int count) {
    final sortedMessages = List<Message>.from(state.messages);
    sortedMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sortedMessages.take(count).toList();
  }

  // 시스템 메시지 추가 (예: 사용자 입장/퇴장)
  void addSystemMessage(String content) {
    final systemMessage = Message(
      id: 'system_${DateTime.now().millisecondsSinceEpoch}',
      roomId: state.currentRoom?.id ?? '',
      userId: 'system',
      userName: 'System',
      content: content,
      timestamp: DateTime.now(),
      
    );

    final updatedMessages = [...state.messages, systemMessage];
    state = state.copyWith(messages: updatedMessages);
  }

  // 에러 클리어
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider 정의
final chatViewModelProvider = StateNotifierProvider<ChatViewModel, ChatState>((ref) {
  return ChatViewModel(ref);
});

// 편의를 위한 개별 Provider들
final chatMessagesProvider = Provider<List<Message>>((ref) {
  return ref.watch(chatViewModelProvider).messages;
});

final chatLoadingProvider = Provider<bool>((ref) {
  return ref.watch(chatViewModelProvider).isLoading;
});

final chatErrorProvider = Provider<String?>((ref) {
  return ref.watch(chatViewModelProvider).error;
});

final currentRoomProvider = Provider<Room?>((ref) {
  return ref.watch(chatViewModelProvider).currentRoom;
});

final canSendMessageProvider = Provider<bool>((ref) {
  return ref.watch(chatViewModelProvider).canSendMessage;
});

final messagesByDateProvider = Provider<Map<String, List<Message>>>((ref) {
  return ref.watch(chatViewModelProvider).messagesByDate;
}); 