import 'package:equatable/equatable.dart';
import '../data/models/room.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object?> get props => [];
}

class RoomLoadRequested extends RoomEvent {}

class RoomLastMessageUpdated extends RoomEvent {
  final String roomId;
  final LastMessage lastMessage;

  const RoomLastMessageUpdated({
    required this.roomId,
    required this.lastMessage,
  });

  @override
  List<Object?> get props => [roomId, lastMessage];
}