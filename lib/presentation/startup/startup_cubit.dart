import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile1_flutter_coding_test/repository/room_repository.dart';
import 'package:mobile1_flutter_coding_test/repository/user_repositoy.dart';

import '../../core/injector.dart';
import '../../repository/message_repository.dart';

class StartupCubit extends Cubit<bool> {
  StartupCubit() : super(false);

  Future<void> start() async {
    try {
      final userRepo = injector<UserRepository>();
      final roomRepo = injector<RoomRepository>();
      final msgRepo = injector<MessageRepository>();

      await userRepo.load();
      await roomRepo.load();
      await msgRepo.load();

      emit(true);
    } catch (e) {
      debugPrint(e.toString());
      emit(false);
    }
  }
}
