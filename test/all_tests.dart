import 'package:flutter_test/flutter_test.dart';

// 모델 테스트
import 'models/user_test.dart' as user_test;
import 'models/room_test.dart' as room_test;
import 'models/message_test.dart' as message_test;

// 데이터 소스 테스트
import 'data_sources/remote_data_source_test.dart' as remote_data_source_test;

// 리포지토리 테스트
import 'repositories/user_repository_test.dart' as user_repository_test;
import 'repositories/room_repository_test.dart' as room_repository_test;

// 위젯 테스트
import 'widget_test.dart' as widget_test;

void main() {
  group('전체 테스트 실행', () {
    group('모델 테스트', () {
      user_test.main();
      room_test.main();
      message_test.main();
    });

    group('데이터 소스 테스트', () {
      remote_data_source_test.main();
    });

    group('리포지토리 테스트', () {
      user_repository_test.main();
      room_repository_test.main();
    });

    group('위젯 테스트', () {
      widget_test.main();
    });
  });
} 