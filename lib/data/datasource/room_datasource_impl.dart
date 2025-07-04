import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/room_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/model/response.dart';
import 'package:mobile1_flutter_coding_test/data/remote/rsupport_api_service.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';

class RoomDataSourceImpl implements RoomDataSource {
  RoomDataSourceImpl({required RSupportApiService service})
      : _service = service;
  final RSupportApiService _service;

  @override
  Future<ChatRoomResponse> getRooms() async {
    try {
      return await _service.getRooms();
    } on DioException catch (e) {
      throw e.error as CustomException;
    }
  }
}
