import 'package:json_annotation/json_annotation.dart';
import 'package:mobile1_flutter_coding_test/models/message_model.dart';
part 'messages_response_model.g.dart';

@JsonSerializable()
class MessagesResponseModel {
  final List<MessageModel> messages;

  MessagesResponseModel({
    required this.messages,
  });

  factory MessagesResponseModel.fromJson(Map<String, dynamic> json) => _$MessagesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesResponseModelToJson(this);
}