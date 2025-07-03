import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/my_error.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';

abstract class BaseViewModel<T> extends StateNotifier<T> {
  BaseViewModel(super.state);

  void setLoading(bool isLoading);

  Future<TReturn?> runWithResult<R, TReturn>(
    Future<Result<R>> Function() task, {
    required TReturn Function(R data) onSuccess,
    TReturn Function(MyError error)? onFailure,
  }) async {
    setLoading(true);
    final result = await task();
    await Future.delayed(const Duration(milliseconds: 1000));
    setLoading(false);

    return switch (result) {
      Success<R>(:final data) => onSuccess(data),
      Failure<R>(:final error) => onFailure?.call(error),
    };
  }
}
