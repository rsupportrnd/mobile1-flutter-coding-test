import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/features/chat/presentation/controllers/chat_messages_provider.dart';
import 'package:mobile1_flutter_coding_test/features/chat/domain/repositories/chat_repository.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_message.dart';
import 'package:mobile1_flutter_coding_test/features/user/presentation/controllers/user_list_provider.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/models/user_model.dart';
import 'package:mobile1_flutter_coding_test/features/user/presentation/widgets/user_detail_modal.dart';
import 'package:intl/intl.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  final String roomId;
  final String roomName;

  const ChatRoomPage({
    super.key,
    required this.roomId,
    required this.roomName,
  });

  @override
  ConsumerState<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // 현재 사용자 ID (실제 앱에서는 인증 시스템에서 가져와야 함)
  final String _currentUserId = 'user1';

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final messageText = _messageController.text.trim();
    if (messageText.isEmpty) return;

    try {
      // 메시지 전송
      await ref.read(chatRepositoryProvider).sendMessage(
        roomId: widget.roomId,
        sender: _currentUserId,
        content: messageText,
      );

      _messageController.clear();

      // 메시지 전송 후 채팅 목록 새로고침
      ref.invalidate(chatMessagesControllerProvider(widget.roomId));

      // 메시지 전송 후 스크롤을 하단으로 이동
      _scrollToBottom();
    } catch (e) {
      // 에러 처리
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('메시지 전송에 실패했습니다: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // userId로 사용자 정보 조회하는 헬퍼 메서드
  User? _getUserById(String userId, List<User>? users) {
    if (users == null) return null;
    try {
      return users.firstWhere((user) => user.userId == userId);
    } catch (e) {
      return null;
    }
  }

  // userId로 사용자 이름 조회
  String _getUserNameById(String userId, List<User>? users) {
    final user = _getUserById(userId, users);
    return user?.name ?? userId; // 사용자 정보가 없으면 userId 반환
  }

  // userId로 프로필 이미지 조회
  String? _getProfilePictureById(String userId, List<User>? users) {
    final user = _getUserById(userId, users);
    return user?.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(chatMessagesControllerProvider(widget.roomId));
    final usersAsync = ref.watch(userListControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          // 메시지 리스트
          Expanded(
            child: messagesAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) {
                print(error);
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '메시지를 불러오는 중 오류가 발생했습니다',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.invalidate(chatMessagesControllerProvider(widget.roomId)),
                        child: const Text('다시 시도'),
                      ),
                    ],
                  ),
                );
              },
              data: (messages) {
                if (messages.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          '아직 메시지가 없습니다',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // 메시지를 시간순으로 정렬
                final sortedMessages = List<ChatMessage>.from(messages)
                  ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

                // 스크롤을 맨 아래로 이동
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });

                return usersAsync.when(
                  loading: () => ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: sortedMessages.length,
                    itemBuilder: (context, index) {
                      final message = sortedMessages[index];
                      final isMyMessage = message.sender == _currentUserId;

                      return MessageBubble(
                        message: message,
                        isMyMessage: isMyMessage,
                        senderName: message.sender, // 로딩 중에는 userId 표시
                        profilePicture: null,
                        onProfileTap: null, // 로딩 중에는 클릭 비활성화
                      );
                    },
                  ),
                  error: (error, stackTrace) => ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: sortedMessages.length,
                    itemBuilder: (context, index) {
                      final message = sortedMessages[index];
                      final isMyMessage = message.sender == _currentUserId;

                      return MessageBubble(
                        message: message,
                        isMyMessage: isMyMessage,
                        senderName: message.sender, // 에러 시에도 userId 표시
                        profilePicture: null,
                        onProfileTap: null, // 에러 시에는 클릭 비활성화
                      );
                    },
                  ),
                  data: (users) => ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: sortedMessages.length,
                    itemBuilder: (context, index) {
                      final message = sortedMessages[index];
                      final isMyMessage = message.sender == _currentUserId;
                      final senderName = _getUserNameById(message.sender, users);
                      final profilePicture = _getProfilePictureById(message.sender, users);

                      return MessageBubble(
                        message: message,
                        isMyMessage: isMyMessage,
                        senderName: senderName,
                        profilePicture: profilePicture,
                        onProfileTap: () {
                          final user = _getUserById(message.sender, users);
                          if (user != null) {
                            UserDetailModal.show(context, user);
                          }
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
          // 메시지 입력 영역
          MessageInputField(
            controller: _messageController,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMyMessage;
  final String senderName;
  final String? profilePicture;
  final VoidCallback? onProfileTap;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMyMessage,
    required this.senderName,
    this.profilePicture,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMyMessage) ...[
            GestureDetector(
              onTap: onProfileTap,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey[300],
                backgroundImage: profilePicture != null
                  ? NetworkImage(profilePicture!)
                  : null,
                child: profilePicture == null
                  ? Text(
                      senderName.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMyMessage)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 4),
                    child: Text(
                      senderName,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isMyMessage
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(18).copyWith(
                      bottomRight: isMyMessage ? const Radius.circular(4) : null,
                      bottomLeft: !isMyMessage ? const Radius.circular(4) : null,
                    ),
                  ),
                  child: Text(
                    message.content,
                    style: TextStyle(
                      fontSize: 16,
                      color: isMyMessage ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
                  child: Text(
                    _formatMessageTime(message.timestamp),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isMyMessage) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onProfileTap,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).colorScheme.primary,
                backgroundImage: profilePicture != null
                  ? NetworkImage(profilePicture!)
                  : null,
                child: profilePicture == null
                  ? const Icon(
                      Icons.person,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatMessageTime(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDay = DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (messageDay == today) {
      return DateFormat('HH:mm').format(timestamp);
    } else if (messageDay == today.subtract(const Duration(days: 1))) {
      return '어제 ${DateFormat('HH:mm').format(timestamp)}';
    } else {
      return DateFormat('MM/dd HH:mm').format(timestamp);
    }
  }
}

class MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const MessageInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: '메시지를 입력하세요...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
              ),
            ),
            const SizedBox(width: 8),
            FloatingActionButton(
              onPressed: onSend,
              mini: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}