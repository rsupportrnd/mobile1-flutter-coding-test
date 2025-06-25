import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/data/repository/meeting_room_repository_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile1_flutter_coding_test/src/domain/usecase/meeting_room_usecase.dart';
import 'package:mobile1_flutter_coding_test/src/domain/repository/meeting_room_repository.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/meeting_room_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/message_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/meeting_room_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/message_list_response_model.dart';

class _MockMeetingRoomRepository extends Mock implements MeetingRoomRepository {}

void main() {
  late ProviderContainer container;
  late _MockMeetingRoomRepository mockRepo;

  setUp(() {
    mockRepo = _MockMeetingRoomRepository();
    container = ProviderContainer(overrides: [
      meetingRoomRepositoryProvider.overrideWithValue(mockRepo),
    ]);
  });

  tearDown(() => container.dispose());

  group('MeetingRoomUseCase', () {
    test('getMeetingRoomList returns data on success', () async {
      const MeetingRoomListResponseModel dummyModel =
          MeetingRoomListResponseModel(meetingRooms: []);
      when(() => mockRepo.getMeetingRoomList()).thenAnswer((_) async => dummyModel);

      final MeetingRoomUseCase useCase = container.read(meetingRoomUseCaseProvider);
      final MeetingRoomListResponseEntity result = await useCase.getMeetingRoomList();

      expect(result, MeetingRoomListResponseEntity.fromModel(dummyModel));
      verify(() => mockRepo.getMeetingRoomList()).called(1);
    });

    test('getMeetingRoomList throws when repository fails', () async {
      final Exception exception = Exception('Repo error');
      when(() => mockRepo.getMeetingRoomList()).thenThrow(exception);

      final MeetingRoomUseCase useCase = container.read(meetingRoomUseCaseProvider);

      expect(
        () => useCase.getMeetingRoomList(),
        throwsA(same(exception)),
      );
      verify(() => mockRepo.getMeetingRoomList()).called(1);
    });
  });

  group('MessageUseCase', () {
    test('getMessageList returns data on success', () async {
      const MessageListResponseModel dummyModel = MessageListResponseModel(messages: []);
      when(() => mockRepo.getMessageList()).thenAnswer((_) async => dummyModel);

      final MessageUseCase useCase = container.read(messageUseCaseProvider);
      final MessageListResponseEntity result = await useCase.getMessageList();

      expect(result, MessageListResponseEntity.fromModel(dummyModel));
      verify(() => mockRepo.getMessageList()).called(1);
    });

    test('getMessageList throws when repository fails', () async {
      final Exception exception = Exception('Repo error');
      when(() => mockRepo.getMessageList()).thenThrow(exception);

      final MessageUseCase useCase = container.read(messageUseCaseProvider);

      expect(
        () => useCase.getMessageList(),
        throwsA(same(exception)),
      );
      verify(() => mockRepo.getMessageList()).called(1);
    });
  });
}
