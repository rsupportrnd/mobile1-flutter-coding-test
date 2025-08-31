import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile1_flutter_coding_test/commons/main_module.dart';
import 'package:mobile1_flutter_coding_test/models/message_model.dart';
import 'package:mobile1_flutter_coding_test/models/room_model.dart';
import 'package:mobile1_flutter_coding_test/models/user_model.dart';
import 'package:mobile1_flutter_coding_test/utils/utils.dart';
import 'package:mobile1_flutter_coding_test/view_models/chat_room_view_model.dart';
import 'package:mobile1_flutter_coding_test/views/base_view.dart';
import 'package:mobile1_flutter_coding_test/views/users_detail_view.dart';
import 'package:mobile1_flutter_coding_test/widgets/base_content_widget.dart';
import 'package:mobile1_flutter_coding_test/widgets/base_tile_widget.dart';
import 'package:mobile1_flutter_coding_test/widgets/chat_input_bar_widget.dart';
import 'package:mobile1_flutter_coding_test/widgets/user_role_widget.dart';
import 'package:mobile1_flutter_coding_test/widgets/user_status_widget.dart';

class ChatRoomView extends BaseView<ChatRoomViewModel> {
  ChatRoomView({super.key, required this.room});
  final RoomModel room;
  OverlayEntry? _overlayEntry;

  @override
  void initState(ChatRoomViewModel vm) {
    // TODO: implement initState
    controller.getMessages(room);
    super.initState(vm);
  }

  @override
  void dispose(ChatRoomViewModel vm) {
    // TODO: implement dispose
    super.dispose(vm);
  }

  @override
  Widget builder(BuildContext context, ChatRoomViewModel vm) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.scrollController.jumpTo(controller.scrollController.position.maxScrollExtent);
    });

    final _overlay = Overlay.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

      return BaseContentWidget(
          title: room.roomName,
          action: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () async {
                var usersList = await controller.getParticipants();
                _overlayEntry = OverlayEntry(
                  builder: (context) => Stack(
                    children: [
                      GestureDetector(
                        onTap: () => _overlayEntry!.remove(),
                        behavior: HitTestBehavior.opaque,
                        child: Container(color: Colors.black12),
                      ),
                      Positioned(
                        right: 0,
                        left: null,
                        top: 0,
                        bottom: 0,
                        child: Material(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                SizedBox(height:30),
                                Text ( '참여자 목록 (${usersList.length}명)',
                                    style: TextStyle( fontWeight: FontWeight.bold)),
                                SizedBox(height:3),
                                Expanded(
                                  child: ListView.separated(
                                      controller: controller.scrollController,
                                      scrollDirection: Axis.vertical,
                                      itemCount: usersList.length,
                                      shrinkWrap: true,
                                      separatorBuilder: (_, __) => const SizedBox(height: 5, child: Divider(height: 1)),
                                      itemBuilder: (context, index) {
                                        UserModel user = usersList[index];

                                        return BaseTileWidget(
                                            onTap: () async {
                                              _overlayEntry!.remove();
                                              Get.to(UsersDetailView(user: user));
                                            },
                                            thumbnailPath: user.profilePicture,
                                            content: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(user.name + (user.userId == MainModule.instance.currentUser.userId ? ' (나)' : '' )),
                                                    Row(
                                                        children: [
                                                          UserRoleWidget(userRole: user.role),
                                                          UserStatusWidget(userStatus: user.status)
                                                        ]
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ));
                                      })
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );

                _overlay.insert(_overlayEntry!);
              },
            ),
          ],
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Obx ( () {
                      final messagesList = controller.messagesList;
                      return ListView.separated(
                        controller: controller.scrollController,
                        scrollDirection: Axis.vertical,
                        itemCount: messagesList.length,
                        shrinkWrap: true,
                        separatorBuilder: (_, __) => const SizedBox(height: 10 ),
                        itemBuilder: (context, index) {
                          MessageModel message = messagesList[index];
                          UserModel? user = controller.findUser(message.sender);

                          return Container(
                              // height: 75,
                              child: Directionality(
                                textDirection: user!.userId == MainModule.instance.currentUser.userId ? TextDirection.rtl: TextDirection.ltr,
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: 75,
                                        height: 75,
                                        child: Center(
                                          child: ( user.profilePicture != null && user.profilePicture!.isNotEmpty) ?
                                          InkWell(
                                            onTap: () {
                                              Get.to(UsersDetailView(user: user));
                                            },
                                            child: Container(
                                                width: 50,
                                                height: 50,
                                                decoration:
                                                BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  color: Colors.transparent,
                                                  image: DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                          user.profilePicture!,
                                                          maxWidth: 50,
                                                          maxHeight: 50,
                                                          errorListener: (_) {

                                                          })),
                                                )),
                                          ) : Icon(Icons.account_circle, size: 50, color: Colors.grey),
                                        )),
                                    Expanded(child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Text(user.name)),
                                          SizedBox(height:5),
                                          Bubble(
                                            nip: user.userId == MainModule.instance.currentUser.userId ? BubbleNip.rightTop: BubbleNip.leftTop,
                                            color: user.userId == MainModule.instance.currentUser.userId ? Colors.purple.shade100 : Colors.purple.shade50,
                                            child: Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(message.content),
                                                  Text(message.timestamp.formatKorean())
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    )),
                                  ],
                                ),
                              ));
                        });}),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ChatInputBarWidget(
                    focusNode: controller.focusNode,
                    onSend: (String message) async {
                    await controller.sendMessage(message);
                  }) ),
              ],
            ),
          ));
  }

  @override
  ChatRoomViewModel? get vmProvider => ChatRoomViewModel();

}