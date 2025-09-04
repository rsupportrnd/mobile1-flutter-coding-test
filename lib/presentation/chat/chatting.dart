import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mobile1_flutter_coding_test/core/provider/current_user_provider.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/chat_room.dart';
import 'package:mobile1_flutter_coding_test/presentation/chat/component/room_participants_list.dart';
import 'package:mobile1_flutter_coding_test/presentation/chat/view_model/chat_view_model.dart';
import 'package:mobile1_flutter_coding_test/presentation/user/view_model/user_view_model.dart';
import 'package:mobile1_flutter_coding_test/shared/extension/datetime_formatting.dart';

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

  Widget _buildBubble(BuildContext context, Widget child, bool isSender) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSender ? Colors.indigo[100] : Colors.grey[100],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncMessages = ref.watch(chatViewModelProvider);
    final notifier = ref.watch(chatViewModelProvider.notifier);
    final userList = ref.watch(userViewModelProvider).value?.users ?? [];

    return Scaffold(
      endDrawer: Drawer(
        child: RoomParticipantsList(participants: widget.chatRoom.participants),
      ),
      appBar: AppBar(
        title: Text(widget.chatRoom.roomName),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: Builder(
              builder: (context) => GestureDetector(
                onTap: () async {
                  Scaffold.of(context).openEndDrawer();
                },
                child: const Icon(Icons.people),
              ),
            ),
          )
        ],
      ),
      body: asyncMessages.when(
        data: (data) {
          // 메시지가 로드되면 채팅 컨트롤러에 추가
          WidgetsBinding.instance.addPostFrameCallback((_) {
            notifier.loadMessagesToController(
                data, userList, chatController, widget.chatRoom.roomId);
          });

          return Chat(
            chatController: chatController,
            configuration: ChatConfiguration(
                customInputField: _customInputField,
                bubbleConfiguration: BubbleConfiguration(
                  senderBubbleBuilder: (context, child) {
                    return _buildBubble(context, child, true);
                  },
                  receiverBubbleBuilder: (context, child) {
                    return _buildBubble(context, child, false);
                  },
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
                final currentUser = ref.read(currentUserProvider);
                ref.read(chatViewModelProvider.notifier).sendMessage(
                    _textEditingController.text,
                    chatController,
                    widget.chatRoom.roomId,
                    currentUser);
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
