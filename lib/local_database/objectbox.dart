import 'package:mobile1_flutter_coding_test/index.dart';
import 'package:mobile1_flutter_coding_test/models/entity/message_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../objectbox.g.dart';


class ObjectBox {
  late final Store _store;
  late final Box<MessageEntity> _messageEntityBox;

  ObjectBox._create(this._store) {
    _messageEntityBox = Box<MessageEntity>(_store);
  }

  static Future<ObjectBox> create() async {
    final store = await openStore(
        directory: p.join((await getApplicationDocumentsDirectory()).path,
            "objectbox-database"),
        macosApplicationGroup: "objectbox.database");
    return ObjectBox._create(store);
  }

  Future<void> saveMessage(MessageModel message) async {
    MessageEntity messageEntity = MessageEntity.fromMessageModel(message);
    _messageEntityBox.putAsync(messageEntity);
  }

  Stream<List<MessageEntity>> fetchMessages(String roomId) {
    final builder = _messageEntityBox
        .query(MessageEntity_.roomId.equals(roomId))
        .order(MessageEntity_.timestamp);
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }
}
