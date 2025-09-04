import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/shared/enum/role_type.dart';
import 'package:mobile1_flutter_coding_test/shared/enum/user_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_provider.g.dart';

@riverpod
class CurrentUserProvider extends _$CurrentUserProvider {
  /// 로그인한 사용자는 Alice Kim이라고 정의
  @override
  User build() {
    return User(
      userId: 'user1',
      name: 'Alice Kim',
      email: 'alice.kim@example.com',
      profilePicture: 'https://picsum.photos/id/1011/200/200',
      status: UserStatus.online,
      role: RoleType.admin,
    );
  }
}
