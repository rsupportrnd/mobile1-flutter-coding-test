import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/authorization.dart';

import '../../../../common/common.dart';
import '../../../domain/domain.dart';
import '../../widgets/style_text.dart';

class MessageItem extends StatelessWidget {
  final ChatMessage chatMessage;

  const MessageItem({
    super.key,
    required this.chatMessage,
  });

  @override
  Widget build(BuildContext context) {
    bool isMe = chatMessage.sender == Authorization().userId;

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMe) _buildSenderAvatar(),
        _buildChatBubble(context, isMe),
      ],
    );
  }

  /// 메시지 생성 시간
  _buildTimestamp(DateTime timestamp, bool isMe) {
    return Padding(
      padding: isMe
          ? const EdgeInsets.only(right: AppDim.xSmall)
          : const EdgeInsets.only(left: AppDim.xSmall),
      child: StyleText(
        text: Etc.timestampToDateString(timestamp),
        size: AppDim.fontSizeXxSmall,
        maxLinesCount: 2,
        color: AppColors.black,
      ),
    );
  }

  /// 채팅 메시지
  _buildChatBubble(BuildContext context, bool isMe) {
    double maxWidth = MediaQuery.of(context).size.width * 0.56;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: !isMe,
            child: StyleText(
              text: chatMessage.sender,
              size: AppDim.fontSizeXSmall,
            )),
        AppDim.heightXSmall,

        Row(
          children: [
            if (isMe) _buildTimestamp(chatMessage.timestamp, isMe),
            ChatBubble(
              elevation: UIConstants.elevation2,
              clipper: ChatBubbleClipper5(
                  type: isMe ? BubbleType.sendBubble : BubbleType.receiverBubble),
              alignment: isMe ? Alignment.topRight : Alignment.topLeft,
              margin: EdgeInsets.only(
                  right: isMe ? AppDim.xSmall : 0, bottom: AppDim.medium),
              backGroundColor:
                  isMe ? AppColors.bubbleColor : Colors.grey.shade100,
              child: Container(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: StyleText(
                  text: chatMessage.content,
                  size: isMe ? AppDim.fontSizeSmall : AppDim.fontSizeSmall,
                  maxLinesCount: 20,
                  softWrap: true,
                ),
              ),
            ),
            if (!isMe) _buildTimestamp(chatMessage.timestamp, isMe),
          ],
        ),
      ],
    );
  }

  _buildSenderAvatar() {
    return Padding(
      padding: const EdgeInsets.only(right: AppDim.xSmall),
      child: CircleAvatar(
        radius: AppDim.mediumLarge,
        backgroundColor: AppColors.blueGrey,
        child: StyleText(
          text: '${chatMessage.sender[0]}${chatMessage.sender[chatMessage.sender.length - 1]}',
          color: AppColors.black,
          size: AppDim.fontSizeSmall,
          fontWeight: AppDim.weightBold,
        ),
      ),
    );
  }
}
