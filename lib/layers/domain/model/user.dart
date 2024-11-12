enum UserStatus { online, offline, away, doNotDisturb }
enum UserRole { admin, member }

class User {
  final String id;
  final String name;
  final String email;
  final String profilePictureUrl;
  final UserStatus status;
  final UserRole role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePictureUrl,
    required this.status,
    required this.role,
  });
}


