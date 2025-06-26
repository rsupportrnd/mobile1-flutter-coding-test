import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/room.dart';

abstract class RoomRemoteDataSource {
  Future<List<Room>> fetchRooms();
}

class RoomRemoteDataSourceImpl implements RoomRemoteDataSource {
  final http.Client client;

  RoomRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Room>> fetchRooms() async {
    final url = Uri.parse(
      'https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/rooms.json',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body) as Map<String, dynamic>;
      final roomsJson = jsonMap['chatRooms'] as List;
      final rooms = roomsJson.map((e) => Room.fromJson(e)).toList();

      // 🔽 여기서 timestamp 기준으로 정렬
      rooms.sort(
            (a, b) => b.lastMessage.timestamp.compareTo(a.lastMessage.timestamp),
      );

      return rooms;
    } else {
      throw Exception('Failed to fetch chat rooms: ${response.statusCode}');
    }
  }
}
