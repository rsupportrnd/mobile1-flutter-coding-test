import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_list_response_model.freezed.dart';
part 'message_list_response_model.g.dart';

@freezed
class MessageListResponseModel with _$MessageListResponseModel {
  const factory MessageListResponseModel({
    required List<MessageModel> messages,
  }) = _MessageListResponseModel;

  factory MessageListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MessageListResponseModelFromJson(json);
}

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String roomId,
    required String messageId,
    required String sender,
    required String content,
    required DateTime timestamp,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);
}
