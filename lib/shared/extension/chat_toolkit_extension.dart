import 'package:mobile1_flutter_coding_test/domain/entity/message.dart'
    as entity;
import 'package:mobile1_flutter_coding_test/shared/widgets/chat_toolkit/chat/message/elements/text_message_element.dart';

import '../widgets/chat_toolkit/chat_toolkit.dart';

extension ChatToolkitExtension on Message {
  entity.Message toEntity(String roomId, String sender) {
    return entity.Message(
      roomId: roomId,
      messageId: id,
      sender: sender,
      content: (elements.first as TextMessageElement).text,
      timestamp: timestamp,
    );
  }
}
