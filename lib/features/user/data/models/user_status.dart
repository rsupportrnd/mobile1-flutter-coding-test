enum UserStatus {
  online('online'),
  offline('offline'),
  away('away'),
  doNotDisturb('do_not_disturb');

  const UserStatus(this.value);

  final String value;

  static UserStatus fromString(String status) {
    switch (status) {
      case 'online':
        return UserStatus.online;
      case 'offline':
        return UserStatus.offline;
      case 'away':
        return UserStatus.away;
      case 'do_not_disturb':
        return UserStatus.doNotDisturb;
      default:
        throw ArgumentError('Unknown user status: $status');
    }
  }
}