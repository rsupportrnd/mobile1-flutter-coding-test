import 'package:mobile1_flutter_coding_test/data/datasource/message_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/model/response.dart';
import 'package:mobile1_flutter_coding_test/data/utils/json_loader.dart';

class MessageDataSourceImpl implements MessageDataSource {
  MessageDataSourceImpl({required IJsonLoader jsonLoader})
      : _jsonLoader = jsonLoader;
  final IJsonLoader _jsonLoader;

  @override
  Future<MessageResponse> getMessages() async {
    final jsonMap = await _jsonLoader.loadJson('api/messages.json');
    return MessageResponse.fromJson(jsonMap);
  }
}
