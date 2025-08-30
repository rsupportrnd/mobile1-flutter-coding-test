import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile1_flutter_coding_test/view_models/rooms_view_model.dart';
import 'package:mobile1_flutter_coding_test/views/base_view.dart';
import 'package:mobile1_flutter_coding_test/views/chat_room_view.dart';

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
          separatorBuilder: (_, __) => const SizedBox(height: 5),
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () async {
                  Get.to(ChatRoomView(room:roomsList[index]));
                },
                child: Container(height: 300, child: Text('${roomsList[index].roomName}')));
          });
    });
  }

  @override
  RoomsViewModel? get vmProvider => RoomsViewModel();

}