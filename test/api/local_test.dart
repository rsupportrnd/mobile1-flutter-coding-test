import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/api/local/local_data_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LocalDataSource', () {
    final ds = LocalDataSource();

    test('loadUsers() - api/users.json -> List<dynamic>', () async {
      // sanity check: asset 접근 가능?
      final raw = await rootBundle.loadString('api/users.json');
      expect(raw, isNotEmpty);

      final list = await ds.loadUsers();
      expect(list, isA<List<dynamic>>());
      expect(list, isNotEmpty);

      final first = list.first as Map<String, dynamic>;
      expect(first, contains('userId'));
      expect(first, contains('name'));
    });

    test('loadRooms() - api/rooms.json -> List<dynamic>', () async {
      final raw = await rootBundle.loadString('api/rooms.json');
      expect(raw, isNotEmpty);

      final list = await ds.loadRooms();
      expect(list, isA<List<dynamic>>());
      expect(list, isNotEmpty);

      final first = list.first as Map<String, dynamic>;
      expect(first, contains('roomId'));
      expect(first, contains('roomName'));
    });

    test('loadMessages() - api/messages.json -> List<dynamic>', () async {
      final raw = await rootBundle.loadString('api/messages.json');
      expect(raw, isNotEmpty);

      final list = await ds.loadMessages();
      expect(list, isA<List<dynamic>>());
      expect(list, isNotEmpty);

      final first = list.first as Map<String, dynamic>;
      expect(first, contains('messageId'));
      expect(first, contains('roomId'));
      expect(first, contains('content'));
    });
  });
}
