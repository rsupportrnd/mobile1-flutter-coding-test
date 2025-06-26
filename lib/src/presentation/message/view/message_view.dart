part of '../message_screen.dart';

class _MessageListView extends BaseView with UserListState {
  final List<MessageEntity> messages;
  final ScrollController scrollController;
  const _MessageListView({
    required this.messages,
    required this.scrollController,
  });

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    ///아바타를 위한 사용자 목록 가져오기
    final List<UserEntity> users = watchUserListProvider(ref: ref).maybeWhen(
      data: (data) => data.users,
      orElse: () => [],
    );
    final Map<String, UserEntity> userMap = {
      for (final UserEntity user in users) user.userId: user,
    };

    ///메시지 정렬
    final List<MessageEntity> sortedMessages = [...messages]..sort(
        (MessageEntity a, MessageEntity b) =>
            b.timestamp.compareTo(a.timestamp),
      );

    return Align(
      alignment: Alignment.topCenter,
      child: ListView.builder(
        shrinkWrap: true,
        controller: scrollController,
        reverse: true,
        itemCount: sortedMessages.length,
        itemBuilder: (BuildContext context, int index) {
          final MessageEntity message = sortedMessages[index];
          final UserEntity? user = userMap[message.sender];
          return _MessageBubble(
            message: message,
            sender: user,
          );
        },
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final MessageEntity message;
  final UserEntity? sender;
  const _MessageBubble({
    required this.message,
    this.sender,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMe = message.sender == MessageStringConstant.me;
    const Radius radius = Radius.circular(12);

    final BorderRadius borderRadius = BorderRadius.only(
      topLeft: radius,
      topRight: radius,
      bottomLeft: isMe ? radius : Radius.zero,
      bottomRight: isMe ? Radius.zero : radius,
    );

    const Color bubbleColor = AppColors.primary;
    const Color textColor = AppColors.onPrimary;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 12,
      ),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            UserAvatarWidget(
              profilePictureUrl: sender?.profilePicture ?? '',
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMe)
                  Text(
                    sender?.name ?? message.sender,
                    style: AppTextStyle.caption,
                  ),
                Container(
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: borderRadius,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    message.content,
                    style: const TextStyle(color: textColor),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message.timestamp.updateLastMessageDateFormat,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
