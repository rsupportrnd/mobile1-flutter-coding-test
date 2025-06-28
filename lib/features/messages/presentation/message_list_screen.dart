import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobile1_flutter_coding_test/features/users/bloc/user_bloc.dart';

import '../../users/data/models/user.dart';
import '../bloc/message_bloc.dart';
import '../bloc/message_event.dart';
import '../bloc/message_state.dart';

class MessageListScreen extends HookWidget {
  final String roomId;

  const MessageListScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    final messageBloc = context.read<MessageBloc>();

    final textController = useTextEditingController();
    final scrollController = useScrollController();

    // 메시지 초기 로딩
    useEffect(() {
      messageBloc.add(MessageLoadRequested(roomId));
      return null;
    }, [roomId]);

    // 메시지 전송 함수
    void sendMessage() {
      final text = textController.text.trim();
      if (text.isEmpty) return;

      messageBloc.add(MessageSent(roomId: roomId, content: text));
      textController.clear();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          Future.delayed(const Duration(milliseconds: 100), () {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );
          });
        }
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text('메시지 목록 - $roomId')),
      body: Column(
        children: [
          Expanded(
            child: MultiBlocListener(
              listeners: [
                BlocListener<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserLoadFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('사용자 목록 불러오기 실패')),
                      );
                    }
                  },
                ),
              ],
              child: BlocBuilder<MessageBloc, MessageState>(
                builder: (context, messageState) {
                  if (messageState is MessageLoadInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (messageState is MessageLoadSuccess) {
                    // 메시지 로드 완료 시 자동 스크롤
                    useEffect(() {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (scrollController.hasClients) {
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 1),
                            curve: Curves.easeOut,
                          );
                        }
                      });
                      return null;
                    }, [messageState.messages]);

                    return BlocBuilder<UserBloc, UserState>(
                      builder: (context, userState) {
                        if (userState is UserLoadSuccess) {
                          final users = userState.users;
                          final messages = messageState.messages;

                          return ListView.builder(
                            controller: scrollController,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              final user = users.firstWhere(
                                (u) => u.userId == message.sender,
                                orElse: () => User(
                                  userId: message.sender,
                                  profilePicture: '',
                                  name: '',
                                  email: '',
                                  status: UserStatus.offline,
                                  role: UserRole.member,
                                ),
                              );

                              return ListTile(
                                leading: user.profilePicture.isNotEmpty
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(user.profilePicture),
                                      )
                                    : const CircleAvatar(),
                                title: Text(user.name.isEmpty ? '사용자' : user.name),
                                subtitle: Text(message.content),
                                trailing: Text(
                                  DateTime.parse(message.timestamp.toString()).toLocal().toString().substring(11, 16),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            },
                          );
                        } else if (userState is UserLoadInProgress) {
                          return const Center(child: CircularProgressIndicator());
                        } else {
                          return const Center(child: Text('사용자 목록을 불러올 수 없습니다.'));
                        }
                      },
                    );
                  } else if (messageState is MessageLoadFailure) {
                    return Center(child: Text('에러: ${messageState.errorMessage}'));
                  } else {
                    return const Center(child: Text('메시지를 불러올 수 없습니다.'));
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: '메시지를 입력하세요...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: sendMessage,
                  child: const Text('전송'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
