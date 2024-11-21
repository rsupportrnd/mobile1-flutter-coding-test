import 'package:mobile1_flutter_coding_test/index.dart';
import 'package:mobile1_flutter_coding_test/local_database/objectbox.dart';
import 'package:mobile1_flutter_coding_test/models/entity/message_entity.dart';

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

  Future<List<MessageModel>> fetchAllMessages({required String roomId}) async {
    List<MessageModel> messages = [
      ...await _fetchMessageFromLocalDatabase(roomId: roomId),
      ...await _fetchMessagesByRoomNumber(roomId: roomId)
    ];
    return _compareToListOrderByAsc(list: messages);
  }

  Future<List<MessageModel>> _fetchMessageFromLocalDatabase(
      {required String roomId}) async {
    List<MessageModel> dbMessageModels = [];
    Stream<List<MessageEntity>> messages =
        getIt<ObjectBox>().fetchMessages(roomId);
    await for (List<MessageEntity> entityList in messages) {
      if (entityList.isNotEmpty) {
        dbMessageModels =
            entityList.map((e) => MessageModel.fromMessageEntity(e)).toList();
      }
      break;
    }
    return dbMessageModels;
  }

  Future<List<MessageModel>> _fetchMessagesByRoomNumber(
      {required String roomId}) async {
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

  List<MessageModel> _compareToListOrderByAsc(
      {required List<MessageModel> list}) {
    list.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return list;
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

  List<MessageModel> addMessageToList(
      {required MessageModel message, required List<MessageModel> list}) {
    return [...list, message];
  }


  MessageModel? createMessage(
      {required String roomId, required String content, required List<MessageModel> list}) {
      late String lastMessageId;
      if (list.isEmpty) {
        lastMessageId = 'msg0';
      } else {
        lastMessageId = list.last.messageId;
      }
      int lastIndex = int.parse(lastMessageId.split('msg').last);
      return MessageModel(
        roomId: roomId,
        content: content,
        messageId: 'msg${lastIndex + 1}',
        sender: "developer",
        timestamp: DateTime.now().toIso8601String(),
        // timestamp: DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now()),
      );
  }

}
