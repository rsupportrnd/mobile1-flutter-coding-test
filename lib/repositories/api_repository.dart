import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mobile1_flutter_coding_test/api/api_result.dart';
import 'package:mobile1_flutter_coding_test/api/models/requests/messages_request_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/requests/rooms_request_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/requests/users_request_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/responses/messages_response_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/responses/rooms_response_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/responses/users_response_model.dart';
import 'package:mobile1_flutter_coding_test/api/server_api.dart';
import 'package:mobile1_flutter_coding_test/commons/constants.dart';

final Dio _dio = Dio(BaseOptions(headers: {}));

class ApiRepository {

  final ServerApi serverApi = ServerApi(_dio);
  ApiRepository();

  ApiResult<T?> handleResponse<T>(T? data, Exception? exception) {

    if ( data == null ) {
      String exceptionMessage = exception.toString();
      debugPrint (exceptionMessage);
      return ApiResult.error(exceptionMessage);
    }

    return ApiResult.success(data);
  }

  /// 각 원격 JSON 파일 호출 시 파라미터를 전달하는 부분은 없지만,
  /// REST API를 호출하는 상황을 가정하여 각각의 RequestModel을 정의하였음.

  /// 메시지 목록 호출
  Future<ApiResult<MessagesResponseModel?>> getMessages(MessagesRequestModel body) async {
    try {
      var responseData = Constants.localMode == true
          ? await rootBundle.loadString('api/messages.json')
          : await serverApi.getMessages(body);

      return handleResponse(MessagesResponseModel.fromJson(jsonDecode(responseData)), null);
    } on DioException catch (dioException) {
      return handleResponse(null, dioException);
    } catch (exception) {
      return handleResponse(null, exception as Exception);
    }
  }

  /// 회의 목록 호출
  Future<ApiResult<RoomsResponseModel?>> getRooms(RoomsRequestModel body) async {
    try {
      var responseData = Constants.localMode == true
          ? await rootBundle.loadString('api/rooms.json')
          : await serverApi.getRooms(body);

      return handleResponse(RoomsResponseModel.fromJson(jsonDecode(responseData)), null);
    } on DioException catch (dioException) {
      return handleResponse(null, dioException);
    } catch (exception) {
      return handleResponse(null, exception as Exception);
    }
  }

  /// 사용자 목록 호출
  Future<ApiResult<UsersResponseModel?>> getUsers(UsersRequestModel body) async {
    try {
      var responseData = Constants.localMode == true
          ? await rootBundle.loadString('api/users.json')
          : await serverApi.getUsers(body);

      return handleResponse(UsersResponseModel.fromJson(jsonDecode(responseData)), null);
    } on DioException catch (dioException) {
      return handleResponse(null, dioException);
    } catch (exception) {
      return handleResponse(null, exception as Exception);
    }
  }

}