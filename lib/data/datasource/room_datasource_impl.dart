import 'package:mobile1_flutter_coding_test/data/datasource/room_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/model/response.dart';
import 'package:mobile1_flutter_coding_test/data/utils/json_loader.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';

class RoomDataSourceImpl implements RoomDataSource {
  RoomDataSourceImpl({required IJsonLoader jsonLoader})
      : _jsonLoader = jsonLoader;
  final IJsonLoader _jsonLoader;

  @override
  Future<ChatRoomResponse> getRooms() async {
    try {
      final jsonMap = await _jsonLoader.loadJson('api/rooms.json');
      return ChatRoomResponse.fromJson(jsonMap);
    } on JsonLoadException {
      rethrow; // Repository에서 처리
    }
  }
}
