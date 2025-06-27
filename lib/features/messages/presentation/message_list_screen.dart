import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile1_flutter_coding_test/features/users/bloc/user_bloc.dart';
import '../../users/data/models/user.dart';
import '../bloc/message_bloc.dart';
import '../bloc/message_event.dart';
import '../bloc/message_state.dart';

class MessageListScreen extends StatefulWidget {
  final String roomId;

  const MessageListScreen({super.key, required this.roomId});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 화면 초기화 시 메시지 불러오기
    context.read<MessageBloc>().add(MessageLoadRequested(widget.roomId));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    context.read<MessageBloc>().add(
          MessageSent(
            roomId: widget.roomId,
            content: text,
          ),
        );

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('메시지 목록 - ${widget.roomId}')),
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
                    return BlocBuilder<UserBloc, UserState>(
                      builder: (context, userState) {
                        if (userState is UserLoadSuccess) {
                          final users = userState.users;
                          final messages = messageState.messages;

                          return ListView.builder(
                            reverse: true, // 최신 메시지가 아래로 오도록 뒤집기
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[messages.length - 1 - index]; // 역순 처리
                              final user;
                              user = users.firstWhere(
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
                                    : CircleAvatar(
                                        child: Text(user.name),
                                      ),
                                title: Text(user.name == '' ? '사용자' : user.name),
                                subtitle: Text(message.content),
                                trailing: Text(
                                  DateTime.parse(message.timestamp.toString()).toLocal().toString().substring(11, 16), // 시간만 표시 (HH:mm)
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
          // 메시지 입력란
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: '메시지를 입력하세요...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
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
