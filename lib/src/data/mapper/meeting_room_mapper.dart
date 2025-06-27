import 'package:mobile1_flutter_coding_test/src/data/data.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';

final class MeetingRoomMapper {
  const MeetingRoomMapper._();

  static LastMessageEntity lastMessageModelToEntity(
    final LastMessageModel model,
  ) {
    return LastMessageEntity(
      sender: model.sender,
      content: model.content,
      timestamp: model.timestamp,
    );
  }

  static MeetingRoomEntity meetingRoomModelToEntity(
    final MeetingRoomModel model,
  ) {
    return MeetingRoomEntity(
      roomId: model.roomId,
      roomName: model.roomName,
      creator: model.creator,
      participants: List<String>.from(model.participants),
      createdAt: model.createdAt,
      lastMessage: lastMessageModelToEntity(model.lastMessage),
      thumbnailImage: model.thumbnailImage,
    );
  }

  static MeetingRoomListResponseEntity meetingRoomListModelToEntity(
    final MeetingRoomListResponseModel model,
  ) {
    return MeetingRoomListResponseEntity(
      meetingRooms: model.meetingRooms.map(meetingRoomModelToEntity).toList(),
    );
  }
}
