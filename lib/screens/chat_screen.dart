import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/room.dart';
import '../models/user.dart';
import '../models/message.dart';
import '../providers/message_provider.dart';
import '../providers/current_user_provider.dart';
import '../router/navigation_helper.dart';
import '../viewmodels/user_viewmodel.dart';
import '../viewmodels/room_viewmodel.dart';
import '../screens/user_detail_screen.dart';
import '../widgets/user_icon.dart';
import '../config/app_text_styles.dart';
import '../config/app_constants.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final Room room;

  const ChatScreen({super.key, required this.room});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> with WidgetsBindingObserver, RouteAware {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  double _keyboardHeight = 0;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // 포커스 변화 감지
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();

    // 채팅 화면을 벗어날 때 방 목록의 최신 메시지 업데이트
    _refreshRoomListAfterChat();

    super.dispose();
  }

  // 채팅 화면을 벗어난 후 방 목록 업데이트
  void _refreshRoomListAfterChat() {
    try {
      final roomViewModel = ref.read(roomViewModelProvider.notifier);
      roomViewModel.refreshRoomAfterChat(widget.room.id);
    } catch (e) {
      // Provider가 이미 dispose된 경우 등의 에러 처리
      debugPrint('방 목록 업데이트 실패: $e');
    }
  }

  // 사용자 아바타 클릭 시 상세 화면으로 이동
  void _onUserAvatarTapped(User? user) {
    if (user != null) {
      NavigationHelper.to(
        UserDetailScreen(user: user),
        routeName: '/user/${user.id}',
      );
    }
  }

  void _onFocusChange() {
    // 포커스를 받았을 때 즉시 스크롤 준비
    if (_focusNode.hasFocus && !_isKeyboardVisible) {
      // 키보드가 아직 올라오지 않았다면 짧은 지연 후 스크롤
      Future.delayed(AppConstants.dialogShowDuration, () {
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

      // 키보드가 올라오는 중이거나 내려가는 중일 때
      if (_isKeyboardVisible && !wasKeyboardVisible) {
        // 키보드가 올라오기 시작할 때 - 즉시 스크롤
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom(immediate: true);
        });
      } else if (_isKeyboardVisible) {
        // 키보드가 이미 올라와 있고 높이만 변경될 때
        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom({bool force = false, bool immediate = false}) {
    if (_scrollController.hasClients) {
      final maxExtent = _scrollController.position.maxScrollExtent;

      if (immediate) {
        // 즉시 스크롤 (애니메이션 없음)
        _scrollController.jumpTo(maxExtent);
      } else {
        // 애니메이션 스크롤
        final duration = _isKeyboardVisible || force
            ? const Duration(milliseconds: 150)  // 키보드가 있을 때는 빠르게
            : const Duration(milliseconds: 100);

        _scrollController.animateTo(
          maxExtent,
          duration: duration,
          curve: Curves.easeOut,
        );
      }
    }
  }

  void _sendMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    final currentUser = ref.read(currentUserDataProvider);
    if (currentUser == null) return;

    final messageNotifier = ref.read(messageNotifierProvider.notifier);

    await messageNotifier.sendMessage(
      roomId: widget.room.id,
      userId: currentUser.id,
      userName: currentUser.name,
      content: content,
    );

    _messageController.clear();

    // 메시지 전송 후 강제로 스크롤을 맨 아래로
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom(force: true);
    });
  }

  // 사용자 ID로 사용자 정보 찾기
  User? _findUserById(String userId, List<User> users) {
    try {
      return users.firstWhere((user) => user.id == userId);
    } catch (e) {
      return null;
    }
  }

  // 날짜가 바뀌는지 확인
  bool _shouldShowDateSeparator(List<Message> messages, int index) {
    if (index == 0) return true; // 첫 번째 메시지는 항상 날짜 표시

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

  // 날짜 구분선 위젯
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
      dateText = '${date.month}월 ${date.day}일';
    }

    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 16),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey[400])),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              dateText,
              style: AppTextStyles.withColor(
                AppTextStyles.chatTime,
                Colors.grey[600]!,
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey[400])),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(messagesProvider(widget.room.id));
    final currentUser = ref.watch(currentUserDataProvider);
    final usersState = ref.watch(userViewModelProvider);

    return Scaffold(
      // resizeToAvoidBottomInset을 true로 설정하여 키보드에 반응
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.room.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // 메시지 목록
          Expanded(
            child: messagesAsync.when(
              data: (messages) {
                // 메시지가 로드되면 스크롤
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message.userId == currentUser?.id;
                    final messageUser = _findUserById(message.userId, usersState.users);
                    final showDateSeparator = _shouldShowDateSeparator(messages, index);

                    return Column(
                      children: [
                        // 날짜 구분선
                        if (showDateSeparator)
                          _buildDateSeparator(message.timestamp),

                        // 메시지
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: isMe
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              // 상대방 메시지일 때 왼쪽에 아바타
                              if (!isMe) ...[
                                GestureDetector(
                                  onTap: () => _onUserAvatarTapped(messageUser),
                                  child: UserIcon(
                                    user: messageUser,
                                    radius: 20,
                                    showStatusIndicator: true,
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],

                              // 메시지 컨테이너
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: isMe
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    // 발신자 이름 (내 메시지가 아닐 때만)
                                    if (!isMe)
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 4),
                                        child: Text(
                                          message.userName ?? messageUser?.name ?? message.userId,
                                          style: AppTextStyles.withColor(
                                            AppTextStyles.chatUserName,
                                            Colors.grey[600]!,
                                          ),
                                        ),
                                      ),

                                    // 메시지 말풍선
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isMe
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey[300],
                                        borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(20),
                                          topRight: const Radius.circular(20),
                                          bottomLeft: Radius.circular(isMe ? 20 : 4),
                                          bottomRight: Radius.circular(isMe ? 4 : 20),
                                        ),
                                      ),
                                      child: Text(
                                        message.content,
                                        style: AppTextStyles.withColor(
                                          AppTextStyles.chatMessage,
                                          isMe ? Colors.white : Colors.black87,
                                        ),
                                      ),
                                    ),

                                    // 시간 표시
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        _formatTime(message.timestamp),
                                        style: AppTextStyles.chatTime,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // 내 메시지일 때 오른쪽에 아바타
                              if (isMe) ...[
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () => _onUserAvatarTapped(currentUser),
                                  child: UserIcon(
                                    user: currentUser,
                                    radius: 20,
                                    showStatusIndicator: true,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      '메시지를 불러오는데 실패했습니다: $error',
                      style: AppTextStyles.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.refresh(messagesProvider(widget.room.id)),
                      child: const Text('다시 시도'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 메시지 입력란
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: MediaQuery.of(context).viewInsets.bottom > 0
                  ? 12
                  : MediaQuery.of(context).padding.bottom + 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      focusNode: _focusNode,
                      style: AppTextStyles.inputText,
                      decoration: InputDecoration(
                        hintText: '메시지를 입력하세요...',
                        hintStyle: AppTextStyles.inputHint,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                      textInputAction: TextInputAction.send,
                      onTap: () {
                        // 텍스트 필드 탭 시 - 키보드가 이미 올라와 있다면 즉시 스크롤
                        if (_isKeyboardVisible) {
                          _scrollToBottom(immediate: true);
                        }
                        // 키보드가 내려가 있다면 포커스 리스너가 처리
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    onPressed: _sendMessage,
                    mini: true,
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    final timeString = '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

    if (messageDate.isAtSameMomentAs(today)) {
      // 오늘 메시지는 시간만 표시
      return timeString;
    } else if (messageDate.isAtSameMomentAs(yesterday)) {
      // 어제 메시지는 "어제 시간" 형태로 표시
      return '어제 $timeString';
    } else {
      // 그 외는 "월/일 시간" 형태로 표시
      return '${dateTime.month}/${dateTime.day} $timeString';
    }
  }
}