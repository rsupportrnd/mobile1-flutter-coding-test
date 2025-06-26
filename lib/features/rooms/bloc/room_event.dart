import 'package:equatable/equatable.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object?> get props => [];
}

class RoomLoadRequested extends RoomEvent {}
