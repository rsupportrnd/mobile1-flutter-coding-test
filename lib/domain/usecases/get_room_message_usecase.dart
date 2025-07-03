import 'dart:async';

import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/message_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetRoomMessageUseCase {
  final MessageRepository repository;
  final _updateStream = PublishSubject<List<MessageEntity>>();

  GetRoomMessageUseCase(this.repository);

  StreamSubscription<List<MessageEntity>> get stream {
    StreamSubscription<List<MessageEntity>> sub = _updateStream.listen((event) {});
    return sub;
  }

  Future<List<MessageEntity>> call({required String roomId}) async {
    final messages = await repository.getMessages();
    final filtered = messages.where((m) => m.roomId == roomId).toList();
    _updateStream.add(filtered);
    return filtered;
  }

  void removeListener(StreamSubscription<List<MessageEntity>> subscription) {
    subscription.cancel();
  }

  void dispose() {
    _updateStream.close();
  }
}
