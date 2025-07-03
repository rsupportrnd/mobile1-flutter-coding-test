import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/di/viewmodel_provider.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/my_logger.dart';

abstract class LoadingManager {
  bool get isLoading;
  set isLoading(bool value);
}

class LoadingManagerImpl implements LoadingManager {
  final Ref _ref;
  LoadingManagerImpl(this._ref) {
    Log.d("LoadingManagerImpl $hashCode");
  }

  @override
  bool get isLoading => _ref.read(globalLoadingProvider);

  @override
  set isLoading(bool value) {
    Log.d("setIsLoading $value, $hashCode");
    _ref.read(globalLoadingProvider.notifier).state = value;
  }
}
