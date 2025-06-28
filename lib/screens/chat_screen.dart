import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_constants.dart';
import '../config/app_text_styles.dart';
import '../models/message.dart';
import '../models/room.dart';
import '../models/user.dart';
import '../providers/message_provider.dart';
import '../providers/user_provider.dart';
import '../utils/format_helpers.dart';
import '../utils/logger.dart';
import '../widgets/common_widgets.dart';
import '../widgets/user_avatar.dart';
import 'user_detail_screen.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final Room room;

  const ChatScreen({super.key, required this.room});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> 
    with WidgetsBindingObserver {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  double _keyboardHeight = 0;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    Logger.info('채팅 화면 진입: ${widget.room.name}');
    
    WidgetsBinding.instance.addObserver(this);
    _focusNode.addListener(_onFocusChange);
    
    // 메시지 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(messagesProvider.notifier).loadMessages(widget.room.id);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus && !_isKeyboardVisible) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _scrollToBottom(immediate: true);
        }
      });
    }
  }

  @override
  void didChangeMetrics() {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final wasKeyboardVisible = _isKeyboardVisible;
    _isKeyboardVisible = bottomInset > 0;
    
    if (bottomInset != _keyboardHeight) {
      setState(() {
        _keyboardHeight = bottomInset;
      });
      
      if (_isKeyboardVisible && !wasKeyboardVisible) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom(immediate: true);
        });
      } else if (_isKeyboardVisible) {
        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom({bool force = false, bool immediate = false}) {
    if (_scrollController.hasClients) {
      final maxExtent = _scrollController.position.maxScrollExtent;
      
      if (immediate) {
        _scrollController.jumpTo(maxExtent);
      } else {
        final duration = _isKeyboardVisible || force 
            ? const Duration(milliseconds: 150)
            : const Duration(milliseconds: 100);
            
        _scrollController.animateTo(
          maxExtent,
          duration: duration,
          curve: Curves.easeOut,
        );
      }
    }
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    final currentUser = ref.read(currentUserDataProvider);
    if (currentUser == null) return;

    Logger.userAction('메시지 전송', details: {
      'roomId': widget.room.id,
      'messageLength': content.length,
    });

    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      roomId: widget.room.id,
      userId: currentUser.id,
      userName: currentUser.name,
      content: content,
      timestamp: DateTime.now(),
    );

    try {
      await ref.read(messageSendProvider.notifier).sendMessage(
        widget.room.id,
        message,
      );
      
      _messageController.clear();
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom(force: true);
      });
    } catch (e) {
      Logger.error('메시지 전송 실패', error: e);
      
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

  User? _findUserById(String userId, List<User> users) {
    try {
      return users.firstWhere((user) => user.id == userId);
    } catch (e) {
      return null;
    }
  }

  bool _shouldShowDateSeparator(List<Message> messages, int index) {
    if (index == 0) return true;
    
    final currentMessage = messages[index];
    final previousMessage = messages[index - 1];
    
    final currentDate = DateTime(
      currentMessage.timestamp.year,
      currentMessage.timestamp.month,
      currentMessage.timestamp.day,
    );
    final previousDate = DateTime(
      previousMessage.timestamp.year,
      previousMessage.timestamp.month,
      previousMessage.timestamp.day,
    );
    
    return !currentDate.isAtSameMomentAs(previousDate);
  }

  Widget _buildDateSeparator(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);
    
    String dateText;
    if (messageDate.isAtSameMomentAs(today)) {
      dateText = '오늘';
    } else if (messageDate.isAtSameMomentAs(yesterday)) {
      dateText = '어제';
    } else {
      dateText = FormatHelpers.formatDate(date);
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            dateText,
            style: AppTextStyles.caption,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final messagesState = ref.watch(messagesProvider);
    final messages = ref.watch(roomMessagesProvider(widget.room.id));
    final users = ref.watch(usersProvider).users;
    final currentUser = ref.watch(currentUserDataProvider);
    final isSending = ref.watch(isMessageSendingProvider);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.room.name),
            Text(
              widget.room.description,
              style: AppTextStyles.caption.copyWith(color: Colors.white70),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 메시지 목록
          Expanded(
            child: _buildMessageList(messagesState, messages, users, currentUser),
          ),
          
          // 메시지 입력창
          _buildMessageInput(isSending),
        ],
      ),
    );
  }

  Widget _buildMessageList(
    MessagesState messagesState,
    List<Message> messages,
    List<User> users,
    User? currentUser,
  ) {
    if (messagesState.isLoadingForRoom(widget.room.id) && messages.isEmpty) {
      return CommonWidgets.loadingIndicator();
    }

    if (messagesState.getErrorForRoom(widget.room.id) != null && messages.isEmpty) {
      return CommonWidgets.errorWidget(
        message: '메시지를 불러올 수 없습니다: ${messagesState.getErrorForRoom(widget.room.id)}',
        onRetry: () => ref.read(messagesProvider.notifier).loadMessages(widget.room.id),
      );
    }

    if (messages.isEmpty) {
      return CommonWidgets.emptyListWidget(
        icon: Icons.chat_bubble_outline,
        message: '아직 메시지가 없습니다',
        description: '첫 번째 메시지를 보내보세요!',
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final user = _findUserById(message.userId, users);
        final isMyMessage = currentUser?.id == message.userId;
        
        return Column(
          children: [
            // 날짜 구분선
            if (_shouldShowDateSeparator(messages, index))
              _buildDateSeparator(message.timestamp),
            
            // 메시지 버블
            _buildMessageBubble(message, user, isMyMessage),
          ],
        );
      },
    );
  }

  Widget _buildMessageBubble(Message message, User? user, bool isMyMessage) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isMyMessage 
            ? MainAxisAlignment.end 
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMyMessage) ...[
            GestureDetector(
              onTap: () => _onUserAvatarTapped(user),
              child: UserAvatar(
                user: user,
                radius: 20,
                showStatusIndicator: true,
              ),
            ),
            const SizedBox(width: 8),
          ],
          
          Flexible(
            child: Column(
              crossAxisAlignment: isMyMessage 
                  ? CrossAxisAlignment.end 
                  : CrossAxisAlignment.start,
              children: [
                if (!isMyMessage)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      message.userName,
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isMyMessage 
                        ? Theme.of(context).primaryColor
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    message.content,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isMyMessage ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    FormatHelpers.formatTime(message.timestamp),
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          if (isMyMessage) ...[
            const SizedBox(width: 8),
            UserAvatar(
              user: user,
              radius: 20,
              showStatusIndicator: true,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput(bool isSending) {
    return Container(
      padding: EdgeInsets.only(
        left: AppConstants.defaultPadding,
        right: AppConstants.defaultPadding,
        top: AppConstants.defaultPadding,
        bottom: AppConstants.defaultPadding + _keyboardHeight,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: '메시지를 입력하세요...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: IconButton(
              onPressed: isSending ? null : _sendMessage,
              icon: isSending
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _onUserAvatarTapped(User? user) {
    if (user != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => UserDetailScreen(user: user),
        ),
      );
    }
  }
} 