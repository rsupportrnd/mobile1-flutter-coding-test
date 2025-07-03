import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mobile1_flutter_coding_test/di/viewmodel_provider.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key, required String roomId}) : _roomId = roomId;
  final String _roomId;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    Future.microtask(() {
      ref
          .read(chatViewModelProvider.notifier)
          .setRoomId(roomId: widget._roomId);
    });
    super.initState();
  }

  void _sendMessage() {
    final text = _controller.text;
    ref
        .read(chatViewModelProvider.notifier)
        .sendMessage(message: text)
        .then((result) {
      if (mounted) {
        if (result == true) {
          _controller.clear();
        }
      }
    });
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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatViewModelProvider);

    // 메시지 갱신 시 자동 스크롤
    ref.listen(chatViewModelProvider, (_, next) {
      _scrollToBottom();
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text(widget._roomId)),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: state.isLoading
                    ? const SizedBox.shrink()
                    : state.items.isEmpty
                        ? const Center(child: Text("메시지가 없습니다."))
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: state.items.length,
                            itemBuilder: (context, index) {
                              return _chatTile(message: state.items[index]);
                            },
                          ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration:
                            const InputDecoration(hintText: 'Type a message'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () => _sendMessage(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatTile({required Message message}) {
    final isMine = message.sender == "Me";
    final alignment = isMine ? Alignment.centerRight : Alignment.centerLeft;
    final bubbleColor = isMine ? Colors.blueAccent : Colors.grey[300];
    final textColor = isMine ? Colors.white : Colors.black87;
    final borderRadius = isMine
        ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    final timeStr =
        DateFormat('HH:mm').format(DateTime.parse(message.timestamp));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Align(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!isMine)
              Text(
                message.sender,
                style: TextStyle(color: textColor),
              ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: borderRadius,
              ),
              child: Text(
                message.content,
                style: TextStyle(color: textColor),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              timeStr,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
