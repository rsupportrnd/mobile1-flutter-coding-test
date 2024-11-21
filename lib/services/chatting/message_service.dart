import 'package:mobile1_flutter_coding_test/index.dart';

@injectable
class MessageService {
  final MessageRepository _messageRepository;

  MessageService(this._messageRepository);

  Future<List<MessageModel>> _fetchMessages() async {
    try {
      List<MessageModel> response = await _messageRepository.fetchMessages();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MessageModel>> fetchMessagesByRoomNumber({required String roomId}) async{
    try {
      List<MessageModel> response = await _fetchMessages();
      List<MessageModel> roomMessages =
      response.where((e) => e.roomId == roomId).toList();
      roomMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      return roomMessages;
    } catch (e) {
      rethrow;
    }
  }

  void scrollToEnd(ScrollController scrollController) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    });
  }


}
