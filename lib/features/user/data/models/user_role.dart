enum UserRole {
  admin('admin'),
  member('member');

  const UserRole(this.value);

  final String value;

  static UserRole fromString(String role) {
    switch (role) {
      case 'admin':
        return UserRole.admin;
      case 'member':
        return UserRole.member;
      default:
        throw ArgumentError('Unknown user role: $role');
    }
  }
}