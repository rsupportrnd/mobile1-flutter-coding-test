import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/locator/locator.dart';
import 'package:mobile1_flutter_coding_test/common/viewmodel/viewmodel_state.dart';
import 'package:mobile1_flutter_coding_test/common/widgets/liquid_glass/liquid_app_bar.dart';
import 'package:mobile1_flutter_coding_test/common/widgets/liquid_glass/liquid_icon_button.dart';
import 'package:mobile1_flutter_coding_test/common/widgets/liquid_glass/liquid_text_field.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/user_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_room_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_users_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/post_room_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodels/room_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/widgets/message_tile.dart';
import 'package:provider/provider.dart';

@RoutePage()
class RoomPage extends StatelessWidget {
  final String roomId;
  final String roomName;

  const RoomPage({super.key, required this.roomId, required this.roomName});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomViewModel(
        roomId: roomId,
        postRoomMessageUseCase: locator<PostRoomMessageUseCase>(),
        getRoomMessageUseCase: locator<GetRoomMessageUseCase>(),
        getUsersUseCase: locator<GetUsersUseCase>(),
      ),
      child: Scaffold(
        appBar: LiquidAppBar(title: roomName),
        extendBodyBehindAppBar: true,
        body: Consumer<RoomViewModel>(
          builder: (context, viewModel, child) {
            final users = switch (viewModel.usersState) {
              ViewModelStateSuccess<List<UserEntity>> success => success.data,
              _ => <UserEntity>[],
            };

            return switch (viewModel.messagesState) {
              ViewModelStateLoading<List<MessageEntity>>() =>
                const Center(child: CircularProgressIndicator()),
              ViewModelStateError<List<MessageEntity>> error => Center(child: Text(error.error)),
              ViewModelStateSuccess<List<MessageEntity>> success =>
                _MessageList(messages: success.data, users: users),
            };
          },
        ),
      ),
    );
  }
}

class _MessageList extends StatelessWidget {
  final List<MessageEntity> messages;
  final List<UserEntity> users;
  const _MessageList({required this.messages, required this.users});

  @override
  Widget build(BuildContext context) {
    final sortedMessages = messages.sortedBy((message) => message.timestamp).reversed.toList();

    return Stack(
      children: [
        CustomScrollView(
          reverse: true,
          slivers: [
            SliverSafeArea(
              sliver: SliverPadding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 110),
                sliver: SliverList.builder(
                  itemCount: sortedMessages.length,
                  itemBuilder: (context, index) {
                    final message = sortedMessages[index];
                    final user = users.firstOrNullWhere((user) => user.userId == message.sender);
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        MessageTile(message: message, user: user),
                        SizedBox(height: 8),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _MessageInput(),
        ),
      ],
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

  void sendMessage(BuildContext context) async {
    final message = messageController.text;
    if (message.isNotEmpty) {
      await context.read<RoomViewModel>().sendMessage(message);
      messageController.clear();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        PrimaryScrollController.of(context).animateTo(
          PrimaryScrollController.of(context).position.minScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void scrollToBottom(BuildContext context) {
    if (!context.mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: Row(
        spacing: 8,
        children: [
          Expanded(
            child: LiquidTextField(
              controller: messageController,
              hintText: '메시지 입력',
            ),
          ),
          LiquidIconButton(
            icon: Icons.send,
            onPressed: () => sendMessage(context),
          ),
        ],
      ),
    );
  }
}
