import 'package:drift/drift.dart';

@DataClassName('ChatMessageData')
class ChatMessages extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get messageId => text()();
  TextColumn get roomId => text()();
  TextColumn get sender => text()();
  TextColumn get content => text()();
  DateTimeColumn get timestamp => dateTime()();

  // 확장성을 위한 선택적 필드들
  TextColumn get messageType => text().withDefault(const Constant('text'))();
  TextColumn get localId => text().nullable()();
  IntColumn get syncStatus => integer().withDefault(const Constant(1))(); // 0:sending, 1:synced
}