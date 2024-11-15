abstract interface class UseCase<T, Params> {
  Future<T> execute();
}
abstract interface class ParamUseCase<T, Params> {
  Future<T> execute(Params params);
}

abstract interface class SyncUseCase<T, Params> {
  T execute();
}