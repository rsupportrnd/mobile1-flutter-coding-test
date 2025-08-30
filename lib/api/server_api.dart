
import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/api/models/requests/messages_request_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/requests/rooms_request_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/requests/users_request_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/responses/messages_response_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/responses/response_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/responses/rooms_response_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/responses/users_response_model.dart';
import 'package:mobile1_flutter_coding_test/commons/constants.dart';
import 'package:retrofit/retrofit.dart';

part 'server_api.g.dart';

@RestApi(baseUrl: Constants.serverApiBaseUrl)
abstract class ServerApi {
  factory ServerApi(Dio dio, {String? baseUrl}) = _ServerApi;
  
  @GET('/messages.json')
  Future<String> getMessages(@Body() MessagesRequestModel body);

  @GET('/rooms.json')
  Future<String> getRooms(@Body() RoomsRequestModel body);

  @GET('/users.json')
  Future<String> getUsers(@Body() UsersRequestModel body);

}