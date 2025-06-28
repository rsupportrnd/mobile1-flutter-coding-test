import 'package:mobile1_flutter_coding_test/app/index.dart';

import 'package:equatable/equatable.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<UserLoadRequested>(_onUserLoadRequested);
  }

  Future<void> _onUserLoadRequested(UserLoadRequested event, Emitter<UserState> emit) async {
    emit(UserLoadInProgress());
    try {
      final users = await userRepository.getUsers();
      emit(UserLoadSuccess(users: users));
    } catch (e) {
      emit(UserLoadFailure(errorMessage: e.toString()));
    }
  }
}
