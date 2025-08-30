import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/models/room_model.dart';
import 'package:mobile1_flutter_coding_test/view_models/chat_room_view_model.dart';
import 'package:mobile1_flutter_coding_test/views/base_view.dart';
import 'package:mobile1_flutter_coding_test/widgets/base_content_widget.dart';

class ChatRoomView extends BaseView<ChatRoomViewModel> {
  const ChatRoomView({super.key, required this.room});
  final RoomModel room;

  @override
  void initState(ChatRoomViewModel vm) {
    // TODO: implement initState
    controller.getMessages(room.roomId);
    super.initState(vm);
  }

  @override
  void dispose(ChatRoomViewModel vm) {
    // TODO: implement dispose
    super.dispose(vm);
  }

  @override
  Widget builder(BuildContext context, ChatRoomViewModel vm) {

    return BaseContentWidget(
        title: room.roomName,
        child: ListView.separated(
            controller: controller.scrollController,
            scrollDirection: Axis.vertical,
            itemCount: controller.messagesList.length,
            shrinkWrap: true,
            separatorBuilder: (_, __) => const SizedBox(height: 5),
            itemBuilder: (context, index) {
              return Container(height: 300, child: Text(controller.messagesList[index].content));
            }));
  }

  @override
  ChatRoomViewModel? get vmProvider => ChatRoomViewModel();

}