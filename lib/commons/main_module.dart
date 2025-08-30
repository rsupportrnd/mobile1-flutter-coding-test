import 'package:get/get.dart';
import 'package:mobile1_flutter_coding_test/api/api_result.dart';
import 'package:mobile1_flutter_coding_test/api/models/requests/messages_request_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/requests/rooms_request_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/requests/users_request_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/responses/messages_response_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/responses/rooms_response_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/responses/users_response_model.dart';
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
  get storageRepository => _storageRepository;
  final DbRepository _dbRepository = DbRepository();
  get dbRepository => _dbRepository;
  final ApiRepository _apiRepository = ApiRepository();
  get apiRepository => _apiRepository;

  final RxList<MessageModel> messagesList = <MessageModel>[].obs;
  final RxList<RoomModel> roomsList = <RoomModel>[].obs;
  final RxList<UserModel> usersList = <UserModel>[].obs;

  Future<void> init() async {
    await _storageRepository.init();
    await _dbRepository.open('database.db');

    await _getDataFromApi();
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
      for (var message in messages) {
        messagesList.add(message);
      }
    }

    var rooms = await _dbRepository.fetchRoomsAll();
    if (rooms != null ) {
      for (var room in rooms) {
        roomsList.add(room);
      }
    }
    var users = await _dbRepository.fetchUsersAll();
    if (users != null ) {
      for (var user in users) {
        usersList.add(user);
      }
    }
  }
}