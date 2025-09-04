import 'package:mobile1_flutter_coding_test/core/network/response_result.dart';
import 'package:mobile1_flutter_coding_test/data/repository/user_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_provider.g.dart';

@riverpod
Future<List<User>> users(UsersRef ref) async {
  final userRepository = ref.read(userRepositoryProvider);
  
  try {
    final response = await userRepository.getUsers();
    
    if (response.isSuccess) {
      return response.data;
    } else {
      throw Exception('Failed to load users: ${response.code}');
    }
  } catch (e) {
    throw Exception('Error loading users: $e');
  }
}
