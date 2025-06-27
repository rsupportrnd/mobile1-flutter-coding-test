import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/models/user.dart';
import '../data/repositories/user_repository.dart';

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
