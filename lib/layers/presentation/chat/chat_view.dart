import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/widgets/future_handler.dart';
import 'package:provider/provider.dart';

import '../widgets/frame_scaffold.dart';
import 'chat_viewmodel.dart';
import 'widget/message_list.dart';
import 'widget/text_composer.dart';

class ChatView extends StatefulWidget {
  final String title;
  final String roomId;

  const ChatView({
    super.key,
    required this.title,
    required this.roomId,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ChatViewModel>(context, listen: false);
      provider.initRoomId(widget.roomId); // 방 아이디 초기화
      provider.fetchChatMessageList(); // 채팅 메시지 목록 가져오기
    });
  }

  @override
  Widget build(BuildContext context) {
    return FrameScaffold(
        appBarTitle: widget.title,
        isDefaultPadding: false,
        isKeyboardHide: true,
        body: Consumer<ChatViewModel>
          (builder: (context, provider, child) {
          return FutureHandler(
            isLoading: provider.isLoading,
            isError: provider.isError,
            errorMessage: provider.errorMessage,
            onRetry: provider.onRetry,
            child: Column(
              children: [
                /// 문자 리스트(말풍선 리스트)
                MessageList(
                  chatMessages: provider.chatMessageList,
                ),

                /// 메시지 입력란
                const TextComposer(),
              ],
            ),
          );
        }));
  }
}
