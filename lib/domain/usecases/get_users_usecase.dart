import 'dart:async';

import 'package:mobile1_flutter_coding_test/domain/entities/user_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetUsersUseCase {
  final UserRepository repository;
  final _updateStream = PublishSubject<List<UserEntity>>();

  GetUsersUseCase(this.repository);

  StreamSubscription<List<UserEntity>> get stream {
    StreamSubscription<List<UserEntity>> sub = _updateStream.listen((event) {});
    return sub;
  }

  Future<List<UserEntity>> call() async {
    final users = await repository.getUsers();
    _updateStream.add(users);
    return users;
  }

  void dispose() {
    _updateStream.close();
  }
}
