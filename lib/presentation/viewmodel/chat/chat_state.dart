import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';

part 'chat_state.freezed.dart';

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState(
      {@Default(false) bool isLoading,
      @Default("empty") String roomId,
      @Default([]) List<Message> items}) = _ChatState;
}
