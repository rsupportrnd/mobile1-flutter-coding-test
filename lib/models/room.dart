import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required String name,
    String? description,
    required String creator,
    required List<String> participants,
    DateTime? createdAt,
    Map<String, dynamic>? lastMessage,
    String? thumbnailImage,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  
  const Room._();

  int get participantCount => participants.length;

  String? get lastMessageContent {
    final messageMap = lastMessage;
    if (messageMap == null) return null;
    
    final content = messageMap['content'];
    return content?.toString();
  }
  
  DateTime? get lastMessageTime {
    final messageMap = lastMessage;
    if (messageMap == null) return null;
    
    final timestamp = messageMap['timestamp'];
    if (timestamp == null) return null;
    
    try {
      return DateTime.parse(timestamp.toString());
    } catch (e) {
      return null;
    }
  }
  
  bool get isActive {
    final messageTime = lastMessageTime;
    if (messageTime == null) return false;
    
    // 마지막 메시지가 1시간 이내면 활성화된 것으로 check
    final now = DateTime.now();
    return now.difference(messageTime).inHours < 1;
  }
  
  String get initials {
    if (name.isNotEmpty) {
      return name[0].toUpperCase();
    }
    return '회';
  }
} 