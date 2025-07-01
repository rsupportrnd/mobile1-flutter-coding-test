import 'package:mobile1_flutter_coding_test/data/datasource/message_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/model/response.dart';
import 'package:mobile1_flutter_coding_test/data/utils/json_loader.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';

class MessageDataSourceImpl implements MessageDataSource {
  MessageDataSourceImpl({required IJsonLoader jsonLoader})
      : _jsonLoader = jsonLoader;
  final IJsonLoader _jsonLoader;

  @override
  Future<MessageResponse> getMessages() async {
    try {
      final jsonMap = await _jsonLoader.loadJson('api/messages.json');
      return MessageResponse.fromJson(jsonMap);
    } on JsonLoadException {
      rethrow; // Repository에서 처리
    }
  }
}
