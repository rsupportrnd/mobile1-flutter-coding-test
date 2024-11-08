# RSUPPORT mobile1 flutter developer test

    알서포트 코딩 테스트 참여에 감사 드립니다.
    본 테스트는 지원자의 개발 및 협업 역량을 예측하기 위하여 진행합니다.
    요구 사항을 만족하는 코드를 작성해 주세요.
    작성된 코드는 인터뷰에 활용됩니다.

# 요구 사항
1. 주어진 사용자 스토리를 만족하는 flutter 앱을 작성합니다.
2. 앱 작성을 완료한 후, Pull Request 생성합니다.
3. PR 링크 첨부하여 담당자 메일(recruit@rsupport.com)로 회신합니다.
4. 질문은 kimss@rsupport.com 으로 메일 보내주십시오. 확인이 되면 가급적 바로 회신하겠습니다.

## 사용자 스토리

- 앱 실행 시 최초 화면은 사용자 목록 화면이다.
- 사용자는 화면 하단의 아이콘을 사용해 사용자 목록 화면과 회의 목록 화면으로 전환할 수 있다.
- 사용자 목록에서 각 사용자를 터치하여 상세 정보를 확인할 수 있다.
- 회의 목록에서 각 회의를 터치하여 해당 회의의 채팅 화면으로 이동할 수 있다.
- 채팅화면 하단에 메시지 입력란이 있으며, 전송한 메시지는 로컬에 저장되고 메시지 목록에 반영된다.

## 제공되는 가상 API

- 사용자 목록 - https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/users.json
- 회의실 목록 - https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/rooms.json
- 메시지 목록 - https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/messages.json

## 참고 사항

- 사용자 스토리 흐름을 크게 변경하지 않는 범위에서 보완하거나 추가해도 좋습니다.
- UI의 세부적인 디자인 요소는 평가하지 않으니, 레이아웃 구조를 간단하게 구현해도 무방합니다.
- 상태 관리는 평소 사용하던 방법으로 자유롭게 진행해 주세요.

## 가산점

1. **코드 가독성** - 명확하고 이해하기 쉬운 코드
2. **Flutter 이해도** - Flutter의 기능을 적절히 활용하는 능력
3. **Git 사용 능숙도** - 커밋의 빈도와 메세지 관리, 브랜칭 관리
4. **테스트 코드 추가** - 코드의 신뢰성을 높일 수 있는 테스트 코드 작성
5. **GitHub Actions 활용** - 자동화된 빌드 및 테스트 설정
   
## github PR 제출 방법
1. 우측 Fork 버튼을 눌러 자신의 github 공간으로 fork 합니다.
2. git clone
3. 작업 완료 후, git push
4. fork된 github의 Pull Requests 로 이동하여 PR 을 작성합니다.
5. 생성된 PR 링크를 메일(recruit@rsupport.com) 에 첨부합니다.
