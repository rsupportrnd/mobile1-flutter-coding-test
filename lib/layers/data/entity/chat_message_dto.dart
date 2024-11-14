import 'package:json_annotation/json_annotation.dart';
part 'chat_message_dto.g.dart';

@JsonSerializable()
class ChatMessageDTO {
  final String roomId;
  final String messageId;
  final String sender;
  final String content;
  final DateTime timestamp;

  ChatMessageDTO({
    required this.roomId,
    required this.messageId,
    required this.sender,
    required this.content,
    required this.timestamp,
  });

  /// JSON 데이터를 ChatMessageDTO로 변환
  factory ChatMessageDTO.fromJson(Map<String, dynamic> json) => _$ChatMessageDTOFromJson(json);

  /// ChatMessageDTO를 JSON 데이터로 변환
  Map<String, dynamic> toJson() => _$ChatMessageDTOToJson(this);

  /// JSON 데이터 리스트를 ChatMessageDTO 리스트로 변환
  static List<ChatMessageDTO> jsonList(List<dynamic> json) {
    return json
        .map((item) => ChatMessageDTO.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}