// message_event.dart

import 'package:equatable/equatable.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class MessageLoadRequested extends MessageEvent {
  final String roomId;

  const MessageLoadRequested(this.roomId);

  @override
  List<Object> get props => [roomId];
}

class MessageSent extends MessageEvent {
  final String roomId;
  final String content;

  const MessageSent({required this.roomId, required this.content});

  @override
  List<Object> get props => [roomId, content];
}
