import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/data/model/response.dart';
import 'package:retrofit/retrofit.dart';

part 'rsupport_api_service.g.dart';

@RestApi()
abstract class RSupportApiService {
  factory RSupportApiService(Dio dio, {String baseUrl}) = _RSupportApiService;

  @GET("/users.json")
  Future<UserResponse> getUsers();

  @GET("/messages.json")
  Future<MessageResponse> getMessages();

  @GET("/rooms.json")
  Future<ChatRoomResponse> getRooms();
}
