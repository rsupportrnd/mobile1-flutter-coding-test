import 'package:dio/dio.dart' hide Headers;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/config/api_config.dart';
import 'package:mobile1_flutter_coding_test/src/core/dio/dio.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/user_list_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_datasource.g.dart';

@riverpod
UserDatasource userDatasource(Ref ref) {
  final Dio dio = ref.read(dioProvider);
  const String baseUrl = ApiConfig.baseUrl;
  return UserDatasource(dio, baseUrl: baseUrl);
}

@RestApi()
abstract class UserDatasource {
  factory UserDatasource(Dio dio, {String baseUrl}) = _UserDatasource;

  @GET(ApiConfig.userListUrl)
  Future<UserListResponseModel> getUserList();
}
