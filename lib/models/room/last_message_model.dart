import 'package:freezed_annotation/freezed_annotation.dart';

part 'last_message_model.freezed.dart';
part 'last_message_model.g.dart';

@freezed
abstract class LastMessageModel with _$LastMessageModel {
  const factory LastMessageModel({
  required String sender,
  required String content,
  required String timestamp,
  }) = _LastMessageModel;



  factory LastMessageModel.fromJson(Map<String, dynamic> json) =>
      _$LastMessageModelFromJson(json);
}