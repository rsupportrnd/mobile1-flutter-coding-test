part of '../message_screen.dart';

class _MessageListView extends BaseView {
  final List<MessageEntity> messages;
  const _MessageListView({required this.messages});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[messages.length - 1 - index];
        return ListTile(
          title: Text(message.sender),
          subtitle: Text(message.content),
          trailing: Text(message.timestamp.updateLastMessageDateFormat),
        );
      },
    );
  }
}
