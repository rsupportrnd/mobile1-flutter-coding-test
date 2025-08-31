import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mobile1_flutter_coding_test/api/api_result.dart';
import 'package:mobile1_flutter_coding_test/api/models/requests/messages_request_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/requests/rooms_request_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/requests/users_request_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/responses/messages_response_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/responses/rooms_response_model.dart';
import 'package:mobile1_flutter_coding_test/api/models/responses/users_response_model.dart';
import 'package:mobile1_flutter_coding_test/repositories/api_repository.dart';

void main() {
  group('원격 Json 호출 테스트', () {
    late ApiRepository _apiRepository;

    setUp(() {
      _apiRepository = ApiRepository(localMode: false);
    });

    test('메시지 Json 테스트', () async {
      ApiResult<MessagesResponseModel?> apiResult = await _apiRepository.getMessages(MessagesRequestModel());

      expect(apiResult, isA<Success<MessagesResponseModel?>>());
      expect((apiResult as Success<MessagesResponseModel?>).data != null, true);
      expect((apiResult).data!.messages.isNotEmpty, true);
    });

    test('회의실 Json 테스트', () async {
      ApiResult<RoomsResponseModel?> apiResult = await _apiRepository.getRooms(RoomsRequestModel());

      expect(apiResult, isA<Success<RoomsResponseModel?>>());
      expect((apiResult as Success<RoomsResponseModel?>).data != null, true);
      expect((apiResult).data!.chatRooms.isNotEmpty, true);
    });

    test('유저목록 Json 테스트', () async {
      ApiResult<UsersResponseModel?> apiResult = await _apiRepository.getUsers(UsersRequestModel());

      expect(apiResult, isA<Success<UsersResponseModel?>>());
      expect((apiResult as Success<UsersResponseModel?>).data != null, true);
      expect((apiResult).data!.users.isNotEmpty, true);
    });
  });
}