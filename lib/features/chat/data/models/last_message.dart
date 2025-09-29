import 'package:freezed_annotation/freezed_annotation.dart';

part 'last_message.freezed.dart';
part 'last_message.g.dart';

@freezed
abstract class LastMessage with _$LastMessage {
  const factory LastMessage({
    required String sender,
    required String content,
    required DateTime timestamp,
  }) = _LastMessage;

  factory LastMessage.fromJson(Map<String, dynamic> json) => _$LastMessageFromJson(json);
}