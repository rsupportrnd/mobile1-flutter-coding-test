import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/message_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/model/response.dart';
import 'package:mobile1_flutter_coding_test/data/remote/rsupport_api_service.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';

class MessageDataSourceImpl implements MessageDataSource {
  MessageDataSourceImpl({required RSupportApiService service})
      : _service = service;
  final RSupportApiService _service;

  @override
  Future<MessageResponse> getMessages() async {
    try {
      return await _service.getMessages();
    } on DioException catch (e) {
      throw e.error ?? UnKnownException(e.message);
    }
  }
}
