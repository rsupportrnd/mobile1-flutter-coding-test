import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile1_flutter_coding_test/api/api_result.dart';
import 'package:mobile1_flutter_coding_test/api/models/requests/messages_request_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/requests/rooms_request_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/requests/users_request_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/responses/messages_response_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/responses/rooms_response_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/responses/users_response_model.dart';
import 'package:mobile1_flutter_coding_test/commons/constants.dart';
import 'package:mobile1_flutter_coding_test/models/message_model.dart';
import 'package:mobile1_flutter_coding_test/models/room_model.dart';
import 'package:mobile1_flutter_coding_test/models/user_model.dart';
import 'package:mobile1_flutter_coding_test/repositories/api_repository.dart';
import 'package:mobile1_flutter_coding_test/repositories/db_repository.dart';
import 'package:mobile1_flutter_coding_test/repositories/storage_repository.dart';

class MainModule {
  static final MainModule? _instance = MainModule();
  static MainModule get instance {
    return _instance!;
  }

  final StorageRepository _storageRepository = StorageRepository();
  StorageRepository get storageRepository => _storageRepository;
  final DbRepository _dbRepository = DbRepository();
  DbRepository get dbRepository => _dbRepository;
  final ApiRepository _apiRepository = ApiRepository(localMode: Constants.localMode);
  ApiRepository get apiRepository => _apiRepository;

  final RxList<MessageModel> messagesList = <MessageModel>[].obs;
  final RxList<RoomModel> roomsList = <RoomModel>[].obs;
  final RxList<UserModel> usersList = <UserModel>[].obs;

  late UserModel _testUser;
  UserModel get currentUser => _testUser;

  Future<void> init() async {


    await _storageRepository.init();
    await _dbRepository.open(Constants.dbPath);

    await _getDataFromApi();
    await _registerTestUser();
    await _getDataFromDb();
  }

  Future<void> _getDataFromApi() async {
    // 서버 통신 후 DB에 저장
    // 현재는 고정 JSON값 수신이지만, 매 실행시마다 수신 결과가 다른 상황을 가정하여
    // 앱 실행시 항상 통신하고 DB에 저장한다.
    var messagesApiResult = await _apiRepository.getMessages(MessagesRequestModel());
    if (messagesApiResult is Success<MessagesResponseModel?>) {
      for (var messages in messagesApiResult.data!.messages) {
        await _dbRepository.insertMessage(messages);
      }
    }

    var roomsApiResult = await _apiRepository.getRooms(RoomsRequestModel());
    if (roomsApiResult is Success<RoomsResponseModel?>) {
      for (var room in roomsApiResult.data!.chatRooms) {
        await _dbRepository.insertRoom(room);
      }
    }

    var userApiResult = await _apiRepository.getUsers(UsersRequestModel());
    if (userApiResult is Success<UsersResponseModel?>) {
      for (var user in userApiResult.data!.users) {
        await _dbRepository.insertUser(user);
      }
    }
  }

  Future<void> _getDataFromDb() async {
    // DB에 저장한 값을 불러오기
    var messages = await _dbRepository.fetchMessagesAll();
    if (messages != null ) {
      // for (var message in messages) {
      //   messagesList.add(message);
      // }
      messagesList.addAll(messages);
    }

    //
    var rooms = await _dbRepository.fetchRoomsAll();
    if (rooms != null ) {
      roomsList.addAll(rooms);
    }

    var users = await _dbRepository.fetchUsersAll();

    if (users != null ) {

      final topUser = users.where((element) => element.userId == currentUser.userId).toList();
      final others = users.where((element) => element.userId != currentUser.userId).toList();
      users = [...topUser, ...others];

      // for (var user in users) {
      //   usersList.add(user);
      // }
      usersList.addAll(users);
    }

  }

  Future<void> _registerTestUser() async {
    String userJson = "{\"userId\": \"user99\", \"name\": \"H. J. Lee\", \"email\": \"kz0327r@gmail.com\", \"profilePicture\": \"https://storage.googleapis.com/cms-storage-bucket/icon_flutter.0dbfcc7a59cd1cf16282.png\", \"status\": \"online\", \"role\": \"member\"}";
    var decodedJson = jsonDecode(userJson);
    _testUser = UserModel.fromJson(decodedJson);

    await _dbRepository.insertUser(currentUser);
  }

  /// 한개 메시지만 전송(저장)하기
  /// 서버 통신하는 상황을 가정하여 메서드 제작
  Future<bool> sendMessage (MessageModel model ) async {
    try {
      await _dbRepository.insertMessage(model);
      messagesList.add(model);
      var lastMessage = LastMessageModel( sender: currentUser.userId,
        content: model.content,
        timestamp: DateTime.now().toUtc());
        await _dbRepository.insertLastMessage(model.roomId,
          lastMessage, replace:true);

      var room = roomsList.firstWhere((r) => r.roomId == model.roomId);
      var updatedRoom = RoomModel(
        roomId: room.roomId,
        roomName: room.roomName,
        creator: room.creator,
        participants: room.participants,
        createdAt: room.createdAt,
        lastMessage: lastMessage,
        thumbnailImage: room.thumbnailImage
      );

      var index = roomsList.indexOf(room);
      roomsList[index] = updatedRoom;
      roomsList.sort ( (a, b) => b.lastMessage.timestamp.compareTo(a.lastMessage.timestamp));
      roomsList.refresh();

    } catch ( e ) {
      debugPrint (e.toString());
      return false;
    }
    return true;
  }
}