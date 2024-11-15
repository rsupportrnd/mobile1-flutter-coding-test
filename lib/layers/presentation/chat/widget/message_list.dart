import 'package:flutter/material.dart';

import '../../../../common/common.dart';
import '../../../domain/model/chat_message.dart';
import 'message_item.dart';

class MessageList extends StatelessWidget {
  final List<ChatMessage> chatMessages;

  const MessageList({
    super.key,
    required this.chatMessages,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDim.xSmall),
        child: ListView.builder(
          padding: AppDim.paddingXSmall,
          reverse: true,
          itemCount: chatMessages.length,
          itemBuilder: (BuildContext context, int index) {
            return MessageItem(chatMessage: chatMessages[index]);
          },
        ),
      ),
    );
  }
}
