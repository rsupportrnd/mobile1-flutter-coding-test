// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:mobile1_flutter_coding_test/presentation/pages/home.dart'
    as _i1;
import 'package:mobile1_flutter_coding_test/presentation/pages/room/room_page.dart'
    as _i3;
import 'package:mobile1_flutter_coding_test/presentation/pages/room_list/room_list_page.dart'
    as _i2;
import 'package:mobile1_flutter_coding_test/presentation/pages/user_list/user_list_page.dart'
    as _i4;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.RoomListPage]
class RoomListRoute extends _i5.PageRouteInfo<void> {
  const RoomListRoute({List<_i5.PageRouteInfo>? children})
      : super(RoomListRoute.name, initialChildren: children);

  static const String name = 'RoomListRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.RoomListPage();
    },
  );
}

/// generated route for
/// [_i3.RoomPage]
class RoomRoute extends _i5.PageRouteInfo<RoomRouteArgs> {
  RoomRoute({
    _i6.Key? key,
    required String roomId,
    required String roomName,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          RoomRoute.name,
          args: RoomRouteArgs(key: key, roomId: roomId, roomName: roomName),
          initialChildren: children,
        );

  static const String name = 'RoomRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RoomRouteArgs>();
      return _i3.RoomPage(
        key: args.key,
        roomId: args.roomId,
        roomName: args.roomName,
      );
    },
  );
}

class RoomRouteArgs {
  const RoomRouteArgs({this.key, required this.roomId, required this.roomName});

  final _i6.Key? key;

  final String roomId;

  final String roomName;

  @override
  String toString() {
    return 'RoomRouteArgs{key: $key, roomId: $roomId, roomName: $roomName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RoomRouteArgs) return false;
    return key == other.key &&
        roomId == other.roomId &&
        roomName == other.roomName;
  }

  @override
  int get hashCode => key.hashCode ^ roomId.hashCode ^ roomName.hashCode;
}

/// generated route for
/// [_i4.UserListPage]
class UserListRoute extends _i5.PageRouteInfo<void> {
  const UserListRoute({List<_i5.PageRouteInfo>? children})
      : super(UserListRoute.name, initialChildren: children);

  static const String name = 'UserListRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.UserListPage();
    },
  );
}
