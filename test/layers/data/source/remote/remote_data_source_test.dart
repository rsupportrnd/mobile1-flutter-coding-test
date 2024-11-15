import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/layers/data/data.dart';

import 'package:mockito/mockito.dart';

import '../../../../mock/utils/mocks_asset_bundle.dart';

void main() {
  // 테스트를 위한 Flutter Binding 초기화
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAssetBundle mockAssetBundle;
  late String mockUserJson;
  late String mockMeetingRoomJson;

  setUp(() {
    // Mock AssetBundle 객체 생성
    mockAssetBundle = MockAssetBundle();

    // Mock User JSON 데이터 설정
    mockUserJson = jsonEncode({
      "users": [
        {
          "userId": "user1",
          "name": "Alice Kim",
          "email": "alice.kim@example.com",
          "profilePicture": "https://picsum.photos/id/1011/200/200",
          "status": "online",
          "role": "admin"
        },
        {
          "userId": "user2",
          "name": "Bob Lee",
          "email": "bob.lee@example.com",
          "profilePicture": "https://picsum.photos/id/1012/200/200",
          "status": "offline",
          "role": "member"
        },
      ]
    });

    // Mock MeetingRoom JSON 데이터 설정
    mockMeetingRoomJson = jsonEncode({
      "chatRooms": [
        {
          "roomId": "room1",
          "roomName": "프로젝트 A 회의",
          "creator": "user1",
          "participants": ["user1", "user2", "user3"],
          "createdAt": "2024-11-01T09:00:00Z",
          "lastMessage": {
            "sender": "user2",
            "content": "다음 회의는 언제로 할까요?",
            "timestamp": "2024-11-07T15:30:00Z"
          },
          "thumbnailImage": "https://picsum.photos/id/1011/200/200"
        },
        {
          "roomId": "room2",
          "roomName": "개발자 채팅방",
          "creator": "user4",
          "participants": ["user4", "user5", "user2"],
          "createdAt": "2024-10-25T14:30:00Z",
          "lastMessage": {
            "sender": "user5",
            "content": "코드 리뷰 부탁드립니다.",
            "timestamp": "2024-11-07T14:45:00Z"
          },
          "thumbnailImage": "https://picsum.photos/id/1012/200/200"
        },
      ]
    });


  });

  group('RemoteDataSource - loadString Tests', () {

    test('Users JSON 데이터를 성공적으로 가져오고 파싱하여 jsonString 반환을 확인한다.', () async {
      when(mockAssetBundle.loadString('assets/api/users.json')).thenAnswer((_) async => mockUserJson);

      // 실행: 파일에서 JSON 데이터 읽어오기
      final response = await mockAssetBundle.loadString('assets/api/users.json');
      List<dynamic> jsonList = json.decode(response)['users'];
      final result = UserDTO.jsonList(jsonList);

      // 예상 결과 검증
      expect(result, isA<List<UserDTO>>());
      expect(result.length, 2);
      expect(result[0].name, 'Alice Kim');
      expect(result[1].name, 'Bob Lee');
    });

    test('잘못된 Users JSON 데이터로 오류가 발생해야 한다', () async {
      when(mockAssetBundle.loadString('assets/api/users.json')).thenThrow(Exception('invalid json'));

      // 예외가 발생하는지 확인
      expect(() => mockAssetBundle.loadString('assets/api/users.json'), throwsException);
    });


    test('Rooms JSON 데이터를 성공적으로 가져오고 파싱하여 jsonString 반환을 확인한다.', () async {
      when(mockAssetBundle.loadString('assets/api/rooms.json')).thenAnswer((_) async => mockMeetingRoomJson);

      // 실행: 파일에서 JSON 데이터 읽어오기
      final response = await mockAssetBundle.loadString('assets/api/rooms.json');
      List<dynamic> jsonList = json.decode(response)['chatRooms'];
      final result = MeetingRoomDTO.jsonList(jsonList);

      // 예상 결과 검증
      expect(result, isA<List<MeetingRoomDTO>>());
      expect(result.length, 2);
      expect(result[0].roomName, '프로젝트 A 회의');
      expect(result[1].roomName, '개발자 채팅방');
    });

    test('잘못된 Rooms JSON 데이터로 오류가 발생해야 한다', () async {
      when(mockAssetBundle.loadString('assets/api/rooms.json')).thenThrow(Exception('invalid json'));

      // 예외가 발생하는지 확인
      expect(() => mockAssetBundle.loadString('assets/api/rooms.json'), throwsException);
    });
  });
}