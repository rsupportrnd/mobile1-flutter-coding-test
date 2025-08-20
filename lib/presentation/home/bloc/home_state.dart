part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(0) int navIdx,
    @Default('') String currentUserId,
    @Default('') String currentUserName,
  }) = _HomeState;
}
