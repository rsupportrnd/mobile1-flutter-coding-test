import 'package:dio/dio.dart' hide Headers;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/config/api_config.dart';
import 'package:mobile1_flutter_coding_test/src/core/dio/dio.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/meeting_room_list_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meeting_room_datasource.g.dart';

@riverpod
MeetingRoomDatasource meetingRoomDatasource(Ref ref) {
  final Dio dio = ref.read(dioProvider);
  const String baseUrl = ApiConfig.baseUrl;
  return MeetingRoomDatasource(dio, baseUrl: baseUrl);
}

@RestApi()
abstract class MeetingRoomDatasource {
  factory MeetingRoomDatasource(Dio dio, {String baseUrl}) =
      _MeetingRoomDatasource;

  @GET(ApiConfig.meetingRoomListUrl)
  Future<MeetingRoomListResponseModel> getMeetingRoomList();
}
