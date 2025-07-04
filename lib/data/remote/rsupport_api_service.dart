import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/data/model/response.dart';
import 'package:mobile1_flutter_coding_test/data/utils/api_config.dart';
import 'package:retrofit/retrofit.dart';

part 'rsupport_api_service.g.dart';

@RestApi()
abstract class RSupportApiService {
  factory RSupportApiService(Dio dio, {String baseUrl}) = _RSupportApiService;

  @GET(ApiConfig.userUrl)
  Future<UserResponse> getUsers();

  @GET(ApiConfig.messageUrl)
  Future<MessageResponse> getMessages();

  @GET(ApiConfig.roomUrl)
  Future<ChatRoomResponse> getRooms();
}
