import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/layers/data/data.dart';

import 'package:mockito/mockito.dart';

import '../../../../mock/utils/mocks_asset_bundle.dart';

//@GenerateMocks([AssetBundle])
void main() {
  // 테스트를 위한 Flutter Binding 초기화
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAssetBundle mockAssetBundle;
  late String mockJson;

  setUp(() {
    // Mock AssetBundle 객체 생성
    mockAssetBundle = MockAssetBundle();

    // Mock JSON 데이터 설정
    mockJson = jsonEncode({
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
  });

  group('RemoteDataSource - loadString Tests', () {

    test('JSON 데이터를 성공적으로 가져오고 파싱하여 jsonString 반환을 확인한다.', () async {
      when(mockAssetBundle.loadString('assets/api/users.json')).thenAnswer((_) async => mockJson);

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

    test('잘못된 JSON 데이터로 오류가 발생해야 한다', () async {
      when(mockAssetBundle.loadString('assets/api/users.json')).thenThrow(Exception('invalid json'));

      // 예외가 발생하는지 확인
      expect(() => mockAssetBundle.loadString('assets/api/users.json'), throwsException);
    });
  });
}