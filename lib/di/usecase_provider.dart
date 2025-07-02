import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/get_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/get_room_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/get_user_usecase.dart';
import 'package:mobile1_flutter_coding_test/di/repository_provider.dart';

final getMessageUseCaseProvider = Provider<GetMessageUseCase>((ref) =>
    GetMessageUseCase(repository: ref.read(messageRepositoryProvider)));

final getRoomUseCaseProvider = Provider<GetRoomUseCase>(
    (ref) => GetRoomUseCase(repository: ref.read(roomRepositoryProvider)));

final getUserUseCaseProvider = Provider<GetUserUseCase>(
    (ref) => GetUserUseCase(repository: ref.read(userRepositoryProvider)));
