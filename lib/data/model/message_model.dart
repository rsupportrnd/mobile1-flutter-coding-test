import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageListModel with _$MessageListModel {
  factory MessageListModel({
    required List<MessageModel> messages,
  }) = _MessageListModel;

  factory MessageListModel.fromJson(Map<String, dynamic> json) =>
      _$MessageListModelFromJson(json);
}

@freezed
class MessageModel with _$MessageModel {
  factory MessageModel({
    required String roomId,
    required String messageId,
    required String sender,
    required String content,
    required String timestamp,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
