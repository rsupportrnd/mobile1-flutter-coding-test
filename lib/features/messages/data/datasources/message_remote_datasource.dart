import 'package:mobile1_flutter_coding_test/app/index.dart';
import 'package:http/http.dart' as http;

abstract class MessageRemoteDataSource {
  Future<List<Message>> fetchMessages();
}

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final http.Client client;

  MessageRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Message>> fetchMessages() async {
    final url = Uri.parse(
      'https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/messages.json',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body) as Map<String, dynamic>;
      final messagesJson = jsonMap['messages'] as List;

      return messagesJson.map((e) => Message.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch messages: ${response.statusCode}');
    }
  }
}
