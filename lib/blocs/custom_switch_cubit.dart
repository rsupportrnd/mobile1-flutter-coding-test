import 'package:bloc/bloc.dart';

class CustomSwitchCubit extends Cubit<bool> {
  CustomSwitchCubit(super.initialState);

  void updateState(bool value) {
    emit(value);
  }
}
