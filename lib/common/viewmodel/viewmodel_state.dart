sealed class ViewModelState<T> {
  const ViewModelState();

  factory ViewModelState.success({required T data}) = ViewModelStateSuccess<T>;
  factory ViewModelState.error({required String error}) = ViewModelStateError<T>;
  factory ViewModelState.loading() = ViewModelStateLoading<T>;
}

class ViewModelStateSuccess<T> extends ViewModelState<T> {
  final T data;

  const ViewModelStateSuccess({required this.data});
}

class ViewModelStateError<T> extends ViewModelState<T> {
  final String error;

  ViewModelStateError({required this.error});
}

class ViewModelStateLoading<T> extends ViewModelState<T> {
  ViewModelStateLoading();
}
