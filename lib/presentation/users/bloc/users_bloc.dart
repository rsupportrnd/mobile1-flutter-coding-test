import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/core/injector.dart';
import 'package:mobile1_flutter_coding_test/repository/user_repositoy.dart';

part 'users_event.dart';
part 'users_state.dart';
part 'users_bloc.freezed.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(const UsersState()) {
    on<UsersEvent>((event, emit) async {
      await event.when(
        load: () async {
          emit(state.copyWith(loading: true));
          try {
            final repo = injector<UserRepository>();
            await repo.load();
            final users = repo.users;
            emit(state.copyWith(loading: false, users: users));
          } catch (e) {
            emit(state.copyWith(loading: false, error: e.toString()));
          }
        },
        setCurrentUser: (userId) async {
          emit(state.copyWith(currentUserId: userId));
        },
      );
    });
  }
} 