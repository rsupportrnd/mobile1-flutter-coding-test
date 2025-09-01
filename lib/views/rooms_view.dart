import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile1_flutter_coding_test/models/room_model.dart';
import 'package:mobile1_flutter_coding_test/view_models/rooms_view_model.dart';
import 'package:mobile1_flutter_coding_test/views/base_view.dart';
import 'package:mobile1_flutter_coding_test/views/chat_room_view.dart';
import 'package:mobile1_flutter_coding_test/utils/utils.dart';

class RoomsView extends BaseView<RoomsViewModel> {
  const RoomsView({super.key});

  @override
  void initState(RoomsViewModel vm) {
    // TODO: implement initState
    super.initState(vm);
  }

  @override
  void dispose(RoomsViewModel vm) {
    // TODO: implement dispose
    super.dispose(vm);
  }

  @override
  Widget builder(BuildContext context, RoomsViewModel vm) {
    return Obx ( () {
      var roomsList = controller.roomsList;
      return ListView.separated(
          controller: controller.scrollController,
          scrollDirection: Axis.vertical,
          itemCount: roomsList.length,
          shrinkWrap: true,
          separatorBuilder: (_, __) => const SizedBox(height: 5, child: Divider(height: 1)),
          itemBuilder: (context, index) {
            RoomModel room = roomsList[index];

            return InkWell(
                onTap: () async {
                  Get.to(ChatRoomView(room: room));
                },
                child: Container(
                    height: 85,
                    child: Row(
                      children: [
                        SizedBox(
                            width: 85,
                            height: 85,
                            child: Center(
                              child: (room.thumbnailImage != null && room.thumbnailImage!.isNotEmpty) ?
                              Container(
                                  width: 50,
                                  height: 50,
                                  decoration:
                                  BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.transparent,
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            room.thumbnailImage!,
                                            maxWidth: 50,
                                            maxHeight: 50,
                                            errorListener: (_) {

                                            })),
                                  )) : Icon(Icons.chat, size: 50, color: Colors.grey),
                            )),
                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text ( room.roomName,
                            style: TextStyle( fontWeight: FontWeight.bold)),
                            Text ( room.lastMessage.content ),
                            Text ('마지막 메시지: ${room.lastMessage.timestamp.formatKorean()}',
                            style: TextStyle(color: Colors.black54)
                            ),
                            Text ('생성 일시: ${room.createdAt.formatKorean()}',
                            style: TextStyle(color: Colors.black54))
                          ],
                        )),
                      ],
                    )));
          });
    });
  }

  @override
  RoomsViewModel? get vmProvider => RoomsViewModel();

}