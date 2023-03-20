import '../entities/switch_status.dart';

abstract class SwitchRepository {
  Future<SwitchStatus> getStatus(String key);
  Future<bool> saveStatus(SwitchStatus switchStatus);
}
