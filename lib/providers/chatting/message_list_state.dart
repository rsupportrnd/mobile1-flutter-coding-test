part of 'message_list_cubit.dart';

@freezed
class MessageListState with _$MessageListState {

  // const factory MessageListState({
  //   required List<MessageModel> messages,
  // }) = _MessageListState;

  const factory MessageListState.initial() = _Initial;
  const factory MessageListState.loading() = _Loading;
  const factory MessageListState.loaded(List<MessageModel> messages) = _Loaded;
  const factory MessageListState.error(String error) = _Error;
}
