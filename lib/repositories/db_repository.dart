import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobile1_flutter_coding_test/commons/enums.dart';
import 'package:mobile1_flutter_coding_test/models/message_model.dart';
import 'package:mobile1_flutter_coding_test/models/room_model.dart';
import 'package:mobile1_flutter_coding_test/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DbRepository {

  late Database db;

  /// DB 초기화
  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          try {
            await db.execute('''
            create table messages (
            roomId text not null,
            messageId text primary key not null,
            sender text not null,
            content text not null,
            timestamp integer not null)
            ''');

            await db.execute('''
            create table rooms (
            roomId text primary key not null,
            roomName text not null,
            creator text not null,
            participants text not null,
            createdAt integer not null,
            thumbnailImage text
            )
            ''');

            await db.execute('''
            create table roomsLastMessage (
              roomId text primary key not null,
              sender text not null,
              content text not null,
              timestamp integer not null
            )
            ''');

            await db.execute('''
            create table users (
              userId text primary key not null,
              name text not null,
              email text not null,
              profilePicture text,
              status int,
              role int
            )
            ''');

            debugPrint( 'db created!');
          } catch ( e ) {
            debugPrint ( e.toString() );
          }
        });
  }

  /// 메시지 추가
  /// model: 추가할 메시지
  Future<bool> insertMessage(MessageModel model) async {
    try {
      var jsonModel = model.toJson();
      await db.insert('messages', jsonModel, conflictAlgorithm: ConflictAlgorithm.replace);
    } catch ( e ) {
      debugPrint ( e.toString());
      return false;
    }

    return true;
  }

  /// 회의실 추가
  /// model: 추가할 회의실
  Future<bool> insertRoom(RoomModel model) async {
    try {
      var jsonModel = model.toJson();

      // lastMessage 제외한 부분을 rooms에 넣음
      // participants는 json 직렬화 하여 한 필드에 넣음
      var modifiedJson = Map.fromEntries(
          jsonModel.entries.where((element) => element.key != 'lastMessage')).map((key, value) {
        if ( key == 'participants') {
          return MapEntry(key, jsonEncode(value));
        }
        return MapEntry(key, value);
      });
      await db.insert('rooms', modifiedJson, conflictAlgorithm: ConflictAlgorithm.replace);
      await insertLastMessage(modifiedJson['roomId'], model.lastMessage);

    } catch ( e ) {
      debugPrint ( e.toString());
      return false;
    }

    return true;
  }

  /// 마지막 메시지 추가
  /// roomId: 마지막 메시지를 입력시킬 회의실
  /// lastMessage: 입력시킬 마지막 메시지
  /// replace (기본값 false): true이면 입력값(lastMessage)으로 덮어쓴다.
  Future<bool> insertLastMessage(String roomId, LastMessageModel lastMessage, {bool replace = false}) async {
    try {
      var lastMessageJson = lastMessage.toJson();
      lastMessageJson['roomId'] = roomId;
      await db.insert('roomsLastMessage', lastMessageJson, conflictAlgorithm: (replace == true) ? ConflictAlgorithm.replace : ConflictAlgorithm.ignore);
    } catch ( e ) {
      debugPrint(e.toString());
      return false;
    }

    return true;
  }

  /// 사용자 추가
  /// model: 추가할 사용자
  Future<bool> insertUser(UserModel model) async {
    try {
      var jsonModel = model.toJson();
      // User의 Status, Role는 숫자로 변환하여 DB에 저장한다.
      var modifiedJsonModel = jsonModel.map( (key, value) {
        if (key == 'status') {
          return MapEntry(key, UserStatus.fromString(value).index);
        } else if (key == 'role') {
          return MapEntry(key, UserRole.fromString(value).index);
        }

        return MapEntry(key, value);
      });
      await db.insert('users', modifiedJsonModel, conflictAlgorithm: ConflictAlgorithm.replace);
    } catch ( e ) {
      debugPrint ( e.toString());
      return false;
    }

    return true;
  }

  /// 메시지 1건 가져오기
  /// roomId: 조회할 회의실 ID
  Future<MessageModel?> fetchMessage(String roomId) async {
    MessageModel? result;
    try {
      var queryResult = await db.query('messages', columns: null, where: '"roomId" = ?', whereArgs: [roomId]);
      result = queryResult.map ( ( element ) {
        return MessageModel.fromJson(element);
      }).toList().firstOrNull;
    } catch ( e ) {
      debugPrint ( e.toString() );
      return null;
    }

    return result;
  }

  /// 전체 메시지 가져오기
  Future<List<MessageModel>?> fetchMessagesAll() async {
    List<MessageModel>? result;
    try {
      var queryResult = await db.query('messages', orderBy: 'timestamp asc');
      result = queryResult.map ( ( element ) {
        return MessageModel.fromJson(element);
      }).toList();
    } catch ( e ) {
      debugPrint ( e.toString() );
      return null;
    }

    return result;
  }

  /// 회의실 1건 가져오기
  /// roomId: 조회할 회의실 ID
  Future<RoomModel?> fetchRoom(String roomId) async {
    RoomModel? result;
    try {
      String sql = '''
      select r.*, m.sender as lastSender, m.content as lastContent, m.timestamp as lastTimestamp
      from rooms r
      left join roomsLastMessage m
      on r.roomId = m.roomId
      where r.roomId = ?
      ''';

      var queryResult = await db.rawQuery(sql, [roomId]);

      result = queryResult.map((element) {
        var modified = element.map((key, value) {
          if (key == 'participants' && value is String) {
            return MapEntry(key, jsonDecode(value));
          }

          return MapEntry(key, value);
        });

        modified['lastMessage'] = {
          'sender': modified['lastSender'],
          'content': modified['lastContent'],
          'timestamp': modified['lastTimestamp'],
        };

        // 필요없는 컬럼 제거
        modified.remove('lastSender');
        modified.remove('lastContent');
        modified.remove('lastTimestamp');

        return RoomModel.fromJson(modified);
      }).toList().firstOrNull;
    } catch ( e ) {
      debugPrint ( e.toString() );
      return null;
    }

    return result;
  }

  /// 회의실 전체 가져오기
  Future<List<RoomModel>?> fetchRoomsAll() async {
    List<RoomModel>? result;
    try {
      String sql = '''
      select r.*, m.sender as lastSender, m.content as lastContent, m.timestamp as lastTimestamp
      from rooms r
      left join roomsLastMessage m
      on r.roomId = m.roomId
      order by m.timestamp desc
      ''';

      var queryResult = await db.rawQuery(sql);

      result = queryResult.map((element) {
        var modified = element.map((key, value) {
          if (key == 'participants' && value is String) {
            return MapEntry(key, jsonDecode(value));
          }

          return MapEntry(key, value);
        });

        modified['lastMessage'] = {
          'sender': modified['lastSender'],
          'content': modified['lastContent'],
          'timestamp': modified['lastTimestamp'],
        };

        // 필요없는 컬럼 제거
        modified.remove('lastSender');
        modified.remove('lastContent');
        modified.remove('lastTimestamp');

        return RoomModel.fromJson(modified);
      }).toList();
    } catch ( e ) {
      debugPrint ( e.toString() );
      return null;
    }

    return result;
  }

  /// 회의실의 마지막 메시지 가져오기
  /// roomId: 조회할 회의실 ID
  Future<LastMessageModel?> fetchLastMessage(String roomId) async {
    LastMessageModel? result;
    try {
     var queryResult = await db.query('roomsLastMessage',  where: '"roomId" = ?', whereArgs: [roomId]);
     result = queryResult.map ( ( element ) {
       return LastMessageModel.fromJson(element);
     }).toList().firstOrNull;

    } catch ( e ) {
      debugPrint ( e.toString());
      return null;
    }

    return result;
  }

  /// 사용자 1건 가져오기
  /// userId: 조회할 사용자
  Future<UserModel?> fetchUser(String userId) async {
    UserModel? result;
    try {
      var queryResult = await db.query('users', columns: null, where: '"userId" = ?', whereArgs: [userId]);
      result = queryResult.map ( ( element ) {
        return UserModel.fromJson(element);
      }).toList().firstOrNull;
    } catch ( e ) {
      debugPrint ( e.toString() );
      return null;
    }

    return result;
  }

  /// 전체 사용자 가져오기
  Future<List<UserModel>?> fetchUsersAll() async {
    List<UserModel>? result;
    try {
      var queryResult = await db.query('users');
      result = queryResult.map ( ( element ) {
        return UserModel.fromJson(element);
      }).toList();
    } catch ( e ) {
      debugPrint ( e.toString() );
      return null;
    }

    return result;
  }

  Future close() async => db.close();
}