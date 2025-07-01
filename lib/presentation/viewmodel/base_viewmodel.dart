import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/my_error.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/my_logger.dart';

abstract class BaseViewModel<T> extends StateNotifier<T> {
  BaseViewModel(super.state);

  void setLoading(bool isLoading);

  Future<void> runWithResult<R>(
    Future<Result<R>> Function() task, {
    required void Function(R data) onSuccess,
    void Function(MyError error)? onFailure,
  }) async {
    Log.d("runWithResult");
    setLoading(true);
    final result = await task();
    await Future.delayed(const Duration(milliseconds: 1000));
    setLoading(false);

    switch (result) {
      case Success():
        onSuccess(result.data);
      case Failure():
        onFailure?.call(result.error);
    }
  }
}
