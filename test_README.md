# �� RSupport 테스트 가이드

RSupport 프로젝트의 테스트 코드 구조와 실행 방법을 설명합니다.

## 📋 테스트 구조

```
test/
├── models/                     
│   ├── user_test.dart         # User 모델 테스트
│   ├── room_test.dart         # Room 모델 테스트
│   └── message_test.dart      # Message 모델 테스트
├── data_sources/              
│   └── remote_data_source_test.dart # HTTP 통신 테스트
├── repositories/              
│   ├── user_repository_test.dart    # 사용자 리포지토리 테스트
│   └── room_repository_test.dart    # 회의실 리포지토리 테스트
├── test_helpers/
│   └── test_data.dart         # 공통 테스트 데이터
├── all_tests.dart             # 전체 테스트 실행기
└── widget_test.dart           # 위젯 테스트
```

## 🚀 테스트 실행 방법

### 기본 실행
```bash
# 전체 테스트 실행
flutter test

# 특정 폴더 테스트
flutter test test/models/
flutter test test/repositories/

# 특정 파일 테스트
flutter test test/models/user_test.dart
```

### 상세 출력
```bash
# 자세한 출력
flutter test --reporter expanded

# 간단한 출력
flutter test --reporter compact
```

## 테스트 내용

모델 테스트 (models/)
- JSON 변환 (직렬화/역직렬화)
- 비즈니스 로직 (`isOnline`, `participantCount` 등)
- 계산된 속성들

데이터 소스 테스트 (data_sources/)
- HTTP 요청/응답 처리
- 네트워크 오류 처리
- 모킹을 통한 API 테스트

- 리포지토리 테스트 (repositories/)
- 캐시 로직
- 데이터 소스 통합
- 오류 상황 처리

위젯 테스트 (widget_test.dart)
- UI 컴포넌트 렌더링
- 사용자 상호작용


1. **테스트 실행**: `flutter test`
2. **특정 테스트**: `flutter test test/models/user_test.dart`
3. **상세 결과**: `flutter test --reporter expanded`
