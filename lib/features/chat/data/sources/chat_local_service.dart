import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_message_table.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_message.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'chat_local_service.g.dart';

@DriftDatabase(tables: [ChatMessages])
class ChatLocalService extends _$ChatLocalService {
  ChatLocalService() : super(_openConnection());

  // 테스트용 생성자
  ChatLocalService.memory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  // 메시지 추가
  Future<int> insertMessage(ChatMessage message) async {
    return await into(chatMessages).insert(
      ChatMessagesCompanion(
        messageId: Value(message.messageId),
        roomId: Value(message.roomId),
        sender: Value(message.sender),
        content: Value(message.content),
        timestamp: Value(message.timestamp),
      ),
    );
  }

  // 새로운 msgId 생성 (전체 메시지 기준 자동 증가)
  Future<String> generateNextMessageId() async {
    final result = await (selectOnly(chatMessages)
          ..addColumns([chatMessages.messageId]))
        .get();

    // 현재 저장된 모든 메시지 ID 중 숫자로 된 것들만 추출하여 최대값 찾기
    int maxId = 0;
    for (final row in result) {
      final messageId = row.read(chatMessages.messageId) ?? '';
      final numericId = int.tryParse(messageId.replaceAll('msg', ''));
      if (numericId != null && numericId > maxId) {
        maxId = numericId;
      }
    }

    return 'msg${maxId + 1}';
  }

  // 사용자가 입력한 새 메시지 저장 (msgId 자동 생성)
  Future<ChatMessage> insertUserMessage({
    required String roomId,
    required String sender,
    required String content,
  }) async {
    final messageId = await generateNextMessageId();
    final timestamp = DateTime.now();

    final message = ChatMessage(
      roomId: roomId,
      messageId: messageId,
      sender: sender,
      content: content,
      timestamp: timestamp,
    );

    await insertMessage(message);
    return message;
  }

  // 대량 메시지 추가 (사전 로딩용)
  Future<void> insertMessages(List<ChatMessage> messages) async {
    await transaction(() async {
      for (final message in messages) {
        await insertMessage(message);
      }
    });
  }

  // 특정 방의 메시지 조회
  Future<List<ChatMessageData>> getMessagesForRoom(String roomId) async {
    return await (select(chatMessages)
          ..where((tbl) => tbl.roomId.equals(roomId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.timestamp)]))
        .get();
  }

  // 특정 방의 메시지 실시간 스트림
  Stream<List<ChatMessageData>> watchMessagesForRoom(String roomId) {
    return (select(chatMessages)
          ..where((tbl) => tbl.roomId.equals(roomId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.timestamp)]))
        .watch();
  }

  // 메시지 검색
  Future<List<ChatMessageData>> searchMessages(String query) async {
    return await (select(chatMessages)
          ..where((tbl) => tbl.content.contains(query))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.timestamp)]))
        .get();
  }

  // 특정 방의 메시지 개수
  Future<int> getMessageCountForRoom(String roomId) async {
    final result = await (selectOnly(chatMessages)
          ..addColumns([chatMessages.id.count()])
          ..where(chatMessages.roomId.equals(roomId)))
        .getSingle();
    return result.read(chatMessages.id.count()) ?? 0;
  }

  // 오래된 메시지 정리
  Future<int> deleteOldMessages(int daysToKeep) async {
    final cutoffDate = DateTime.now().subtract(Duration(days: daysToKeep));
    return await (delete(chatMessages)
          ..where((tbl) => tbl.timestamp.isSmallerThanValue(cutoffDate)))
        .go();
  }

  // 특정 방의 모든 메시지 삭제
  Future<int> deleteMessagesForRoom(String roomId) async {
    return await (delete(chatMessages)
          ..where((tbl) => tbl.roomId.equals(roomId)))
        .go();
  }

  // 모든 메시지 삭제
  Future<int> deleteAllMessages() async {
    return await delete(chatMessages).go();
  }

  // ChatMessageData를 ChatMessage로 변환
  ChatMessage convertToModel(ChatMessageData data) {
    return ChatMessage(
      roomId: data.roomId,
      messageId: data.messageId,
      sender: data.sender,
      content: data.content,
      timestamp: data.timestamp,
    );
  }

  // ChatMessageData 리스트를 ChatMessage 리스트로 변환
  List<ChatMessage> convertToModelList(List<ChatMessageData> dataList) {
    return dataList.map((data) => convertToModel(data)).toList();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'chat_messages.sqlite'));

    return NativeDatabase(file);
  });
}