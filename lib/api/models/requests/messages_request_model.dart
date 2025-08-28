import 'package:json_annotation/json_annotation.dart';
part 'messages_request_model.g.dart';

@JsonSerializable()
class MessagesRequestModel {
  MessagesRequestModel();

  factory MessagesRequestModel.fromJson(Map<String, dynamic> json) => _$MessagesRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessagesRequestModelToJson(this);
}
