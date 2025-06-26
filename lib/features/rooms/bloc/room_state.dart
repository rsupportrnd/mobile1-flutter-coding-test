import 'package:equatable/equatable.dart';
import '../data/models/room.dart';

abstract class RoomState extends Equatable {
  const RoomState();

  @override
  List<Object?> get props => [];
}

class RoomInitial extends RoomState {}

class RoomLoadInProgress extends RoomState {}

class RoomLoadSuccess extends RoomState {
  final List<Room> rooms;

  const RoomLoadSuccess(this.rooms);

  @override
  List<Object?> get props => [rooms];
}

class RoomLoadFailure extends RoomState {
  final String errorMessage;

  const RoomLoadFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
