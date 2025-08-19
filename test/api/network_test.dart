import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/api/network/network_data_source.dart';

void main() {
  group('NetworkDataSource', () {
    late Dio dio;
    late NetworkDataSource ds;

    setUp(() {
      dio = Dio();
      ds = NetworkDataSource(dio);
    });

    test('사용자 목록 조회', () async {
      const url =
          'https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/users.json';
      final list = await ds.fetchList(url, rootKey: 'users');
      expect(list, isA<List<dynamic>>());
      expect((list.first as Map).containsKey('userId'), true);
    });

    test('회의실 목록 조회', () async {
      const url =
          'https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/rooms.json';
      final list = await ds.fetchList(url, rootKey: 'chatRooms');
      expect((list.first as Map).containsKey('roomId'), true);
    });

    test('메시지 목록 조회', () async {
      const url =
          'https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/messages.json';
      final list = await ds.fetchList(url, rootKey: 'messages');
      expect((list.first as Map).containsKey('messageId'), true);
    });
  });
}
