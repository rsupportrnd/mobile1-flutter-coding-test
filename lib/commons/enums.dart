enum UserStatus {
  unknown('unknown'),
  offline('offline'),
  online('online'),
  doNotDisturb('do_not_disturb'),
  away('away');

  final String value;

  const UserStatus(this.value);

  static UserStatus fromString(String value) {
    return UserStatus.values.firstWhere(
          (e) => e.value == value,
      orElse: () => UserStatus.unknown,
    );
  }
}


enum UserRole {
  unknown('unknown'),
  member('member'),
  admin('admin');

  final String value;

  const UserRole(this.value);

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
          (e) => e.value == value,
      orElse: () => UserRole.unknown,
    );
  }
}