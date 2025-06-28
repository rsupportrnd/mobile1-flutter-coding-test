import 'package:mobile1_flutter_coding_test/app/index.dart';

class MessageListScreen extends HookWidget {
  final String roomId;

  const MessageListScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    final scrollController = useScrollController();

    final messageBloc = useMemoized(() => context.read<MessageBloc>(), []);

    useEffect(() {
      messageBloc.add(MessageLoadRequested(roomId));
      return null;
    }, [roomId]);

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

                // 여기서 메시지 상태 변화 감지하고 스크롤 내림 처리
                BlocListener<MessageBloc, MessageState>(
                  listener: (context, state) {
                    if (state is MessageLoadSuccess) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (scrollController.hasClients) {
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 10),
                            curve: Curves.easeOut,
                          );
                        }
                      });
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
                                  DateTime.parse(message.timestamp.toString())
                                      .toLocal()
                                      .toString()
                                      .substring(11, 16),
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
          // 메시지 입력 영역
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
                    onSubmitted: (_) => _sendMessage(context, roomId, textController),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _sendMessage(context, roomId, textController),
                  child: const Text('전송'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(
      BuildContext context,
      String roomId,
      TextEditingController controller,
      ) {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    context.read<MessageBloc>().add(MessageSent(roomId: roomId, content: text));
    controller.clear();
  }
}
