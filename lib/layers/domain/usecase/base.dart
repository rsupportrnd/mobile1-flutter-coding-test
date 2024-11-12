abstract interface class UseCase<T, Params> {
  Future<T> execute();
}
