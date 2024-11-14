import 'package:mobile1_flutter_coding_test/layers/data/entity/meeting_room_dto.dart';

import '../../domain/model/model.dart';
import '../data.dart';

class ChatMapper {
  /// Entity -> Model
  static ChatMessage toDomain(ChatMessageDTO dto) {
    return ChatMessage(
      roomId: dto.roomId,
      messageId: dto.messageId,
      sender: dto.sender,
      content: dto.content,
      timestamp: dto.timestamp,
    );
  }

  /// ChatMessageDTO 리스트를 MeetingRoom 리스트로 변환하는 메서드
  static List<ChatMessage> toDomainList(List<ChatMessageDTO> dtoList) {
    return dtoList.map((dto) => toDomain(dto)).toList();
  }
}
