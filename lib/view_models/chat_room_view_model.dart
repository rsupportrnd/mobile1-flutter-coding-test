import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile1_flutter_coding_test/commons/main_module.dart';
import 'package:mobile1_flutter_coding_test/models/message_model.dart';
import 'package:mobile1_flutter_coding_test/models/room_model.dart';
import 'package:mobile1_flutter_coding_test/models/user_model.dart';
import 'package:mobile1_flutter_coding_test/view_models/base_view_model.dart';

class ChatRoomViewModel extends BaseViewModel {

  RxList<MessageModel> messagesList = <MessageModel>[].obs;
  ScrollController scrollController = ScrollController();
  late RoomModel _room;
  final FocusNode focusNode = FocusNode();

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
  void getMessages( RoomModel room ) {
    _room = room;
    var getMessages = MainModule.instance.messagesList.where( (element) { return element.roomId == _room.roomId; });

    if ( getMessages.isNotEmpty) {
      messagesList.addAll(getMessages);
    }
  }

  Future<bool> sendMessage ( String message ) async {

    late String newMsgId;
    var lastMessage = MainModule.instance.messagesList.lastOrNull;

   if ( lastMessage == null ) {
     newMsgId = 'msg1';
   } else {
     final regex = RegExp(r'^msg(\d+)$');
     final match = regex.firstMatch(lastMessage.messageId);

     if (match != null) {
       final number = int.parse(match.group(1)!);
       final incremented = number + 1;
       newMsgId = 'msg$incremented';
     } else {
       newMsgId = 'msg1';
     }
   }

    var messageModel = MessageModel(
      roomId: _room.roomId,
      messageId: newMsgId,
      sender: MainModule.instance.currentUser.userId,
      content: message,
      timestamp: DateTime.now().toUtc()
    );


    bool result = await MainModule.instance.sendMessage(messageModel);
    messagesList.add(messageModel);

    if ( result == true ) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }

    return result;
  }

  UserModel? findUser ( String userId ) {
    return MainModule.instance.usersList.firstWhereOrNull ( (element) { return element.userId == userId; } );
  }

  Future<List<UserModel>> getParticipants () async {
    List<UserModel> list = [];

    list.add(MainModule.instance.currentUser);

    for ( var userId in _room.participants ) {
      var user = await MainModule.instance.dbRepository.fetchUser(userId);
      if ( user != null ) {
        list.add( user );
      }
    }

    return list;
  }
}