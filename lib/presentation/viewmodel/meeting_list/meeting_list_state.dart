import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/room.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/base_state.dart';

part 'meeting_list_state.freezed.dart';

@freezed
abstract class MeetingListState with _$MeetingListState implements BaseState {
  const factory MeetingListState(
      {@Default(false) bool isLoading,
      @Default([]) List<ChatRoom> items}) = _MeetingListState;
}
