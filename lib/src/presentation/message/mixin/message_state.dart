import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/message_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/message/provider/message_provider.dart';

mixin class MessageState {
  AsyncValue<List<MessageEntity>> watchMessages(
      {required WidgetRef ref, required String roomId}) {
    return ref.watch(messageListProvider(roomId));
  }
}
