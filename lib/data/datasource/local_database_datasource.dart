import 'package:mobile1_flutter_coding_test/data/model/message_model.dart';
import 'package:mobile1_flutter_coding_test/data/model/room_model.dart';

abstract class LocalDatabaseDataSource {
  Future<List<MessageModel>> selectMessages({required String roomId});
  Future<MessageModel> insertMessage({required MessageModel message});
  Future<void> insertMessages({required List<MessageModel> messages});
  Future<List<ChatRoomModel>> selectRooms();
  Future<void> insertRooms({required List<ChatRoomModel> rooms});
}
