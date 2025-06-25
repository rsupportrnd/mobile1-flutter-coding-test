import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/src/data/repository/meeting_room_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/src/domain/repository/meeting_room_repository.dart';
import 'package:mobile1_flutter_coding_test/src/domain/usecase/meeting_room_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/meeting_room_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/message_list_response_model.dart';

class _MockMeetingRoomRepository extends Mock implements MeetingRoomRepository {}

void main() {
  late ProviderContainer container;
  late _MockMeetingRoomRepository mockRepo;

  setUp(() {
    mockRepo = _MockMeetingRoomRepository();
    container = ProviderContainer(
      overrides: [
        meetingRoomRepositoryProvider.overrideWithValue(mockRepo),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('GetMeetingRoomListUseCase', () {
    test('returns data on success', () async {
      const MeetingRoomListResponseModel expected = MeetingRoomListResponseModel(meetingRooms: []);
      when(() => mockRepo.getMeetingRoomList()).thenAnswer((_) async => expected);

      final MeetingRoomListResponseModel result =
          await container.read(getMeetingRoomListUseCaseProvider.future);

      expect(result, expected);
      verify(() => mockRepo.getMeetingRoomList()).called(1);
    });

    test('throws when repository fails', () async {
      final Exception exception = Exception('Repo error');
      when(() => mockRepo.getMeetingRoomList()).thenThrow(exception);

      expect(
        () => container.read(getMeetingRoomListUseCaseProvider.future),
        throwsA(exception),
      );
      verify(() => mockRepo.getMeetingRoomList()).called(1);
    });
  });

  group('GetMessageListUseCase', () {
    test('returns data on success', () async {
      const MessageListResponseModel expected = MessageListResponseModel(messages: []);
      when(() => mockRepo.getMessageList()).thenAnswer((_) async => expected);

      final MessageListResponseModel result =
          await container.read(getMessageListUseCaseProvider.future);

      expect(result, expected);
      verify(() => mockRepo.getMessageList()).called(1);
    });

    test('throws when repository fails', () async {
      final Exception exception = Exception('Repo error');
      when(() => mockRepo.getMessageList()).thenThrow(exception);

      expect(
        () => container.read(getMessageListUseCaseProvider.future),
        throwsA(exception),
      );
      verify(() => mockRepo.getMessageList()).called(1);
    });
  });
}
