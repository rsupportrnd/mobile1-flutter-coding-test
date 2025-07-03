import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/user_repository.dart';

class SelectUserUseCase {
  SelectUserUseCase({required UserRepository repository})
      : _repository = repository;
  final UserRepository _repository;

  Future<Result<List<User>>> call() async => await _repository.selectUsers();
}
