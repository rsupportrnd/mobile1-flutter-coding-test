import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/viewmodel/viewmodel_state.dart';
import 'package:mobile1_flutter_coding_test/data/datasources/user_local_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/datasources/user_remote_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/repositories/message_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_room_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/post_room_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodels/room_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/widgets/message_tile.dart';
import 'package:provider/provider.dart';

class RoomPage extends StatelessWidget {
  static const routeName = '/room';

  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final roomId = args?['roomId'] as String;
    final roomName = args?['roomName'] as String;

    return ChangeNotifierProvider(
      create: (context) => RoomViewModel(
          roomId: roomId,
          postRoomMessageUseCase: PostRoomMessageUseCase(MessageRepositoryImpl(
            remoteDataSource: UserRemoteDataSource(dio: Dio()),
            localDataSource: UserLocalDataSource(),
          )),
          getRoomMessageUseCase: GetRoomMessageUseCase(MessageRepositoryImpl(
            remoteDataSource: UserRemoteDataSource(dio: Dio()),
            localDataSource: UserLocalDataSource(),
          ))),
      child: Scaffold(
        appBar: AppBar(
          title: Text(roomName),
        ),
        body: Consumer<RoomViewModel>(
          builder: (context, viewModel, child) {
            return switch (viewModel.messagesState) {
              ViewModelStateLoading<List<MessageEntity>>() =>
                const Center(child: CircularProgressIndicator()),
              ViewModelStateError<List<MessageEntity>> error => Center(child: Text(error.error)),
              ViewModelStateSuccess<List<MessageEntity>> success => Column(
                  children: [
                    Expanded(child: _MessageList(messages: success.data)),
                    _MessageInput(),
                  ],
                ),
            };
          },
        ),
      ),
    );
  }
}

class _MessageList extends StatelessWidget {
  final List<MessageEntity> messages;
  const _MessageList({required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return MessageTile(message: messages[index]);
      },
    );
  }
}

class _MessageInput extends StatefulWidget {
  @override
  State<_MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<_MessageInput> {
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() async {
    final message = messageController.text;
    if (message.isNotEmpty) {
      await context.read<RoomViewModel>().sendMessage(message);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(
                hintText: '메시지를 입력하세요...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: sendMessage,
            child: const Text('전송'),
          ),
        ],
      ),
    );
  }
}
