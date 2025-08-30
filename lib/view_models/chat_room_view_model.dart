import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile1_flutter_coding_test/commons/main_module.dart';
import 'package:mobile1_flutter_coding_test/models/message_model.dart';
import 'package:mobile1_flutter_coding_test/view_models/base_view_model.dart';

class ChatRoomViewModel extends BaseViewModel {

  RxList<MessageModel> messagesList = <MessageModel>[].obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  void getMessages( String roomId ) {
    var getMessages = MainModule.instance.messagesList.where( (element) { return element.roomId == roomId; });

    if ( getMessages.isNotEmpty) {
      messagesList.addAll(getMessages);
    }
  }
}