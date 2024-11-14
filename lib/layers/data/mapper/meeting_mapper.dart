import 'package:mobile1_flutter_coding_test/layers/data/entity/meeting_room_dto.dart';

import '../../domain/model/model.dart';
import '../entity/entity.dart';

class MeetingMapper {
  /// Entity -> Model
  static MeetingRoom toDomain(MeetingRoomDTO dto) {
    return MeetingRoom(
      roomId: dto.roomId,
      roomName: dto.roomName,
      creator: dto.creator,
      participants: dto.participants,
      createdAt: dto.createdAt,
      lastMessage: dto.lastMessage as LastMessage,
      thumbnailImage: dto.thumbnailImage,
    );
  }

  /// MeetingRoomDTO 리스트를 MeetingRoom 리스트로 변환하는 메서드
  static List<MeetingRoom> toDomainList(List<MeetingRoomDTO> dtoList) {
    return dtoList.map((dto) => toDomain(dto)).toList();
  }
}
