import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/util/api_util.dart';
import 'package:mobile1_flutter_coding_test/src/data/data.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_repository.g.dart';

@riverpod
MessageRepository messageRepository(Ref ref) {
  final LocalMessageDatasource localMessageDatasource =
      ref.read(localMessageDatasourceProvider);
  final RemoteMessageDatasource remoteMessageDatasource =
      ref.read(remoteMessageDatasourceProvider);
  return MessageRepositoryImpl(
    localMessageDatasource: localMessageDatasource,
    remoteMessageDatasource: remoteMessageDatasource,
  );
}

class MessageRepositoryImpl with ApiUtilMixin implements MessageRepository {
  final LocalMessageDatasource _localMessageDatasource;
  final RemoteMessageDatasource _remoteMessageDatasource;

  const MessageRepositoryImpl(
      {required LocalMessageDatasource localMessageDatasource,
      required RemoteMessageDatasource remoteMessageDatasource})
      : _localMessageDatasource = localMessageDatasource,
        _remoteMessageDatasource = remoteMessageDatasource;

  @override
  Future<MessageListResponseModel> getRemoteMessageList() {
    return safeApiCall(() => _remoteMessageDatasource.getRemoteMessageList());
  }

  @override
  Future<List<MessageEntity>> getLocalMessageList({required String roomId}) {
    return _localMessageDatasource.getMessages(roomId: roomId);
  }

  @override
  Future<void> saveMessages({
    required String roomId,
    required List<MessageEntity> messages,
  }) {
    return _localMessageDatasource.saveMessages(
      roomId: roomId,
      messages: messages,
    );
  }
}
