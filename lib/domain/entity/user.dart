import 'package:mobile1_flutter_coding_test/shared/enum/role_type.dart';
import 'package:mobile1_flutter_coding_test/shared/enum/user_status.dart';

class User {
  final String userId;
  final String name;
  final String email;
  final String profilePicture;
  final UserStatus status;
  final RoleType role;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.status,
    required this.role,
  });
}
