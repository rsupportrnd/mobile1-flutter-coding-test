import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/data/data.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

class _MockMeetingRoomRepository extends Mock
    implements MeetingRoomRepository {}

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
      when(() => mockRepo.getMeetingRoomList())
          .thenAnswer((_) async => dummyModel);

      final MeetingRoomUseCase useCase =
          container.read(meetingRoomUseCaseProvider);
      final MeetingRoomListResponseEntity result =
          await useCase.getMeetingRoomList();

      expect(result, MeetingRoomListResponseEntity.fromModel(dummyModel));
      verify(() => mockRepo.getMeetingRoomList()).called(1);
    });

    test('getMeetingRoomList throws when repository fails', () async {
      final Exception exception = Exception('Repo error');
      when(() => mockRepo.getMeetingRoomList()).thenThrow(exception);

      final MeetingRoomUseCase useCase =
          container.read(meetingRoomUseCaseProvider);

      expect(
        () => useCase.getMeetingRoomList(),
        throwsA(same(exception)),
      );
      verify(() => mockRepo.getMeetingRoomList()).called(1);
    });
  });
}
