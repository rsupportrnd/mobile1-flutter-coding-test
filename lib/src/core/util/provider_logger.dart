import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'logger_util.dart';

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    logger.i(
        '[Provider Logger]: ${provider.name ?? provider.runtimeType} didUpdateProvider / pv: $previousValue / nv: $newValue');
  }

  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value,
      ProviderContainer container) {
    logger.i(
        '[Provider Logger]: ${provider.name ?? provider.runtimeType} didAddProvider / value : $value');
  }

  @override
  void providerDidFail(ProviderBase<Object?> provider, Object error,
      StackTrace stackTrace, ProviderContainer container) {
    logger.i(
        '[Provider Logger]: ${provider.name ?? provider.runtimeType} providerDidFail / error : $error');
  }

  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider, ProviderContainer container) {
    logger.i(
        '[Provider Logger]: ${provider.name ?? provider.runtimeType} didDisposeProvider');
  }
}
