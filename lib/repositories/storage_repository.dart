import 'package:get_storage/get_storage.dart';

class StorageRepository {

  //TODO storage path
  final GetStorage _storage = GetStorage();

  bool _initialized = false;

  Future<void> init() async {
    var start = DateTime.now().millisecondsSinceEpoch;
    if (!_initialized) {
      await _storage.initStorage;
      _initialized = true;
    }
  }

  Future<void> setTest () async {
    await _storage.write('test', 'test1234');
  }

  String? getTest() {
    return _storage.read('test') ;
  }
}