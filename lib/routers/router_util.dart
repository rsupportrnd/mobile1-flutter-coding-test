enum AppPath {
  main,
  roomList,
  userList,
  chatting,
}

extension AppPageExtension on AppPath {
  String get toPath {
    switch (this) {
      case AppPath.main:
        return '/main';
      case AppPath.roomList:
        return '/roomList';
      case AppPath.userList:
        return '/userList';
      case AppPath.chatting:
        return '/chatting';
    }
  }

  String get toName {
    switch (this) {
      case AppPath.main:
        return 'main';
      case AppPath.roomList:
        return 'roomList';
      case AppPath.userList:
        return 'userList';
      case AppPath.chatting:
        return 'chatting';
    }
  }
}
