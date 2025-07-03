import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/message_repository.dart';

class PostRoomMessageUseCase {
  final MessageRepository repository;
  final _updateStream = PublishSubject<MessageEntity>();

  PostRoomMessageUseCase(this.repository);

  StreamSubscription<MessageEntity> get stream {
    StreamSubscription<MessageEntity> sub = _updateStream.listen((event) {});
    return sub;
  }

  Future<MessageEntity> call({required MessageEntity message}) async {
    final result = await repository.postMessage(message);
    _updateStream.add(result);
    return result;
  }

  void dispose() {
    _updateStream.close();
  }
}
