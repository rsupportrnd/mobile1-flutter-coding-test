import 'package:mobile1_flutter_coding_test/index.dart';
import 'package:http/http.dart' as http;

@Injectable(as: MessageRepository)
class MessageRepositoryImpl implements MessageRepository {
  @override
  Future<List<MessageModel>> fetchMessages() async {
    final response =
        await http.get(Uri.https(ApiPaths.baseUrl, ApiPaths.messages));
    if (response.statusCode == 200) {
      final MessageResponseModel roomResponseModel =
          MessageResponseModel.fromJson(jsonDecode(response.body));
      return roomResponseModel.messages;
    } else {
      throw Exception('Failed to load rooms');
    }
  }
}
