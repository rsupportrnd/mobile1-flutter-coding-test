import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/injector.dart';
import '../../repository/message_repository.dart';

class StartupCubit extends Cubit<bool> {
  StartupCubit() : super(false);

  Future<void> start() async {
    // toDo: 선 로딩할 작업들
    final MessageRepository messageRepository = injector<MessageRepository>();
    emit(true);
  }
}
