import 'package:dio/dio.dart' hide Headers;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/core.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/message_list_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_message_datasource.g.dart';

@riverpod
RemoteMessageDatasource remoteMessageDatasource(Ref ref) {
  final Dio dio = ref.read(dioProvider);
  const String baseUrl = ApiConfig.baseUrl;
  return RemoteMessageDatasource(dio, baseUrl: baseUrl);
}

@RestApi()
abstract class RemoteMessageDatasource {
  factory RemoteMessageDatasource(Dio dio, {String baseUrl}) =
      _RemoteMessageDatasource;

  @GET(ApiConfig.messageListUrl)
  Future<MessageListResponseModel> getRemoteMessageList();
}
