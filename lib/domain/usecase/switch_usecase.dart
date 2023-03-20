import '../entities/switch_status.dart';
import '../repository/switch_repository.dart';

class SwitchUsecase {
  final SwitchRepository _switchRepository;
  SwitchUsecase(this._switchRepository);

  Future<Map<String, SwitchStatus>> fetchSwitchStatuses(
      List<String> ids) async {
    final map = <String, SwitchStatus>{};
    await Future.wait(
      ids.map(
        (id) => _switchRepository.getStatus(id).then((value) {
          if (value != null) {
            map[id] = value;
          }
        }),
      ),
    );
    return map;
  }

  Future<SwitchStatus?> getStatus(String key) {
    return _switchRepository.getStatus(key);
  }

  Future<bool> saveStatus(SwitchStatus switchStatus) {
    return _switchRepository.saveStatus(switchStatus);
  }
}
