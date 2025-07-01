import 'package:mobile1_flutter_coding_test/common/constants/apis.dart';
import 'package:mobile1_flutter_coding_test/common/network/base_request.dart';
import 'package:mobile1_flutter_coding_test/data/models/message_model.dart';
import 'package:mobile1_flutter_coding_test/data/models/room_model.dart';
import '../models/user_model.dart';

class UserRemoteDataSource extends BaseRequest {
  UserRemoteDataSource({required super.dio});

  // [/api/users.json]
  Future<List<UserModel>> getUsers() async {
    return call(() async {
      final response = await dio.get(Apis.getUsers);
      final users = safeConverter(response.data)['users'] as List<dynamic>;
      return users.map((e) => UserModel.fromJson(e)).toList();
    });
  }

  // [/api/rooms.json]
  Future<List<RoomModel>> getRooms() async {
    return call(() async {
      final response = await dio.get(Apis.getRooms);
      final rooms = safeConverter(response.data)['chatRooms'] as List<dynamic>;
      return rooms.map((e) => RoomModel.fromJson(e)).toList();
    });
  }

  // [/api/messages.json]
  Future<List<MessageModel>> getMessages() async {
    return call(() async {
      final response = await dio.get(Apis.getMessages);
      final messages = safeConverter(response.data)['messages'] as List<dynamic>;
      return messages.map((e) => MessageModel.fromJson(e)).toList();
    });
  }
}
