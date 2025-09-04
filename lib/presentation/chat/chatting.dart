import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/chat_room.dart';
import 'package:mobile1_flutter_coding_test/presentation/chat/state/room_message_state.dart';
import 'package:mobile1_flutter_coding_test/presentation/chat/view_model/chat_view_model.dart';
import 'package:mobile1_flutter_coding_test/presentation/user/view_model/user_view_model.dart';
import 'package:mobile1_flutter_coding_test/shared/extension/datetime_formatting.dart';
import 'package:uuid/uuid.dart';

import '../../shared/widgets/chat_toolkit/chat/message/elements/text_message_element.dart';
import '../../shared/widgets/chat_toolkit/chat_toolkit.dart';

class Chatting extends ConsumerStatefulWidget {
  const Chatting({super.key, required this.chatRoom});
  final ChatRoom chatRoom;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChattingState();
}

class _ChattingState extends ConsumerState<Chatting> {
  late final ChatController chatController;
  final TextEditingController _textEditingController = TextEditingController();
  @override
  initState() {
    super.initState();
    chatController = ChatController();
  }

  @override
  dispose() {
    chatController.dispose();
    _textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncMessages = ref.watch(chatViewModelProvider);
    final userList = ref.watch(userViewModelProvider).value?.users ?? [];

    return Scaffold(
      endDrawer: Drawer(
        child: Column(
          children: [
            Text('Chatting'),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Chatting'),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Scaffold.of(context).openDrawer();
          //   },
          //   icon: const Icon(Icons.menu),
          // ),
        ],
      ),
      body: asyncMessages.when(
        data: (data) {
          // 메시지가 로드되면 채팅 컨트롤러에 추가
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _loadMessagesToController(data, userList);
          });

          return Chat(
            chatController: chatController,
            configuration: ChatConfiguration(
                customInputField: _customInputField,
                bubbleConfiguration: BubbleConfiguration(
                  timeBuilder: (context, timestamp) {
                    return Text(DateTime.parse(timestamp).chatDisplayTime);
                  },
                )),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }

  void _loadMessagesToController(
      RoomMessageState data, List<dynamic> userList) {
    final messages = data.getMessages(widget.chatRoom.roomId);
    List<Message> messageList = [];
    for (var message in messages) {
      final userName =
          userList.firstWhere((user) => user.userId == message.sender).name;
      messageList.add(SenderMessage(
        timestamp: message.timestamp,
        name: userName,
        id: message.messageId ?? const Uuid().v4(),
        elements: [TextMessageElement(text: message.content)],
      ));
    }
    chatController.setMessages(messageList);
    chatController.scrollToBottom();

    Future.delayed(const Duration(milliseconds: 50), () {
      chatController.scrollToBottom();
    });
  }

  Widget _customInputField(BuildContext context, ChatController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide(
                color: const Color(0xFF000000).withValues(alpha: 0.05))),
      ),
      child: Row(
        children: [
          const Gap(20),
          Expanded(
              child: TextFormField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'Reply...',
              hintStyle: TextStyle(
                color: const Color(0xFF0D082C).withValues(alpha: 0.6),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          )),
          GestureDetector(
            onTap: () {
              if (_textEditingController.text.isNotEmpty) {
                ref.read(chatViewModelProvider.notifier).sendMessage(
                    _textEditingController.text,
                    chatController,
                    widget.chatRoom.roomId);
                _textEditingController.clear();
              }
            },
            child: const Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
