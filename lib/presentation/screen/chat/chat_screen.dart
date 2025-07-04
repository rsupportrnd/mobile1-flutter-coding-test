import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mobile1_flutter_coding_test/di/viewmodel_provider.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/room.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key, required ChatRoom room}) : _room = room;
  final ChatRoom _room;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // 현재 프레임 이후에 실행하도록 지연시켜 build가 완료된 후 실행
    Future.microtask(() {
      // microtask 없이 호출할 경우 생명주기 중 State를 변경하여 에러
      ref
          .read(chatViewModelProvider.notifier)
          .setRoomId(roomId: widget._room.roomId);
    });
    super.initState();
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
        appBar: AppBar(
          title: Text(widget._room.roomName),
          leading: IconButton(
            icon: Icon(
              Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
            ),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
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
    // 프레임완료 후 콜백을 실행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut, //천천히 시작해서, 중간에 빠르게, 그리고 천천히 끝나는 효과
        );
      }
    });
  }
}
