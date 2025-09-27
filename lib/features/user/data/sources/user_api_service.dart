import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user_list_response.dart';

part 'user_api_service.g.dart';

@RestApi()
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  @GET('/users.json')
  Future<UserListResponse> getUsers();
}