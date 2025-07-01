import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/network/custom_exceptions.dart';
import 'package:mobile1_flutter_coding_test/common/viewmodel/viewmodel_state.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/room_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_rooms_usecase.dart';

class RoomListViewModel extends ChangeNotifier {
  final GetRoomsUseCase getRoomsUseCase;
  ViewModelState<List<RoomEntity>> _rooms = ViewModelState.loading();
  ViewModelState<List<RoomEntity>> get roomsState => _rooms;

  RoomListViewModel({
    required this.getRoomsUseCase,
  }) {
    fetchRooms();
  }

  void setRooms(ViewModelState<List<RoomEntity>> state) {
    _rooms = state;
    notifyListeners();
  }

  void fetchRooms() async {
    try {
      setRooms(ViewModelState.success(data: await getRoomsUseCase.call()));
    } on NetworkException catch (e) {
      setRooms(ViewModelState.error(error: e.message));
    } on UnknownException catch (e) {
      setRooms(ViewModelState.error(error: e.message));
    } catch (e) {
      setRooms(ViewModelState.error(error: e.toString()));
    }
  }
}
