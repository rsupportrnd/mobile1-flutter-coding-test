import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/util/api_util.dart';
import 'package:mobile1_flutter_coding_test/src/data/datasource/local_message_datasource.dart';
import 'package:mobile1_flutter_coding_test/src/data/datasource/remote_message_datasource.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/message_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/message_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/domain/repository/message_repository.dart';
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
    return safeApiCall(() => _remoteMessageDatasource.getMessageList());
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
