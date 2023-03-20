import 'package:rs_flutter_test/datasource/local/shared_preferences_switch_repository.dart';
import 'package:rs_flutter_test/domain/entities/switch_status.dart';
import 'package:rs_flutter_test/domain/usecase/switch_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  late SwitchUsecase switchUsecase;
  late SharedPreferencesSwitchRepository sharedPreferencesSwitchRepository;
  late SharedPreferences sharedPreferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferencesSwitchRepository = SharedPreferencesSwitchRepository();
    switchUsecase = SwitchUsecase(sharedPreferencesSwitchRepository);
  });

  group('SwitchStatus', () {
    test('fromJson and toJson', () {
      final json = {'key': 'testKey', 'value': true};
      final switchStatus = SwitchStatus.fromJson(json);

      expect(switchStatus.key, 'testKey');
      expect(switchStatus.value, true);

      final toJsonResult = switchStatus.toJson();
      expect(toJsonResult, json);
    });
  });

  group('SharedPreferencesSwitchRepository', () {
    test('getStatus retrieves a SwitchStatus from SharedPreferences', () async {
      await sharedPreferences.setBool(
          '${SharedPreferencesSwitchRepository.prefix}testKey', true);

      final result =
          await sharedPreferencesSwitchRepository.getStatus('testKey');

      expect(result.key, 'testKey');
      expect(result.value, true);
    });

    test('getStatus returns a status false value if key is not found',
        () async {
      final result =
          await sharedPreferencesSwitchRepository.getStatus('testKey');

      expect(result.value, false);
    });

    test('saveStatus saves a SwitchStatus to SharedPreferences', () async {
      final switchStatus = SwitchStatus(key: 'testKey', value: true);

      final result =
          await sharedPreferencesSwitchRepository.saveStatus(switchStatus);

      expect(result, true);
      expect(
          sharedPreferences
              .getBool('${SharedPreferencesSwitchRepository.prefix}testKey'),
          true);
    });
  });

  group('SwitchUsecase', () {
    test('fetchSwitchStatuses retrieves multiple SwitchStatus objects',
        () async {
      await sharedPreferences.setBool(
          '${SharedPreferencesSwitchRepository.prefix}testKey1', true);
      await sharedPreferences.setBool(
          '${SharedPreferencesSwitchRepository.prefix}testKey2', false);

      final result =
          await switchUsecase.fetchSwitchStatuses(['testKey1', 'testKey2']);

      expect(result['testKey1']?.key, 'testKey1');
      expect(result['testKey1']?.value, true);
      expect(result['testKey2']?.key, 'testKey2');
      expect(result['testKey2']?.value, false);
    });

    test('getStatus retrieves a SwitchStatus from SwitchRepository', () async {
      await sharedPreferences.setBool(
          '${SharedPreferencesSwitchRepository.prefix}testKey', true);

      final result = await switchUsecase.getStatus('testKey');

      expect(result.key, 'testKey');
      expect(result.value, true);
    });

    test('getStatus status false value if key is not found', () async {
      final result = await switchUsecase.getStatus('testKey');
      expect(result.value, false);
    });

    test('saveStatus saves a SwitchStatus to SwitchRepository', () async {
      final switchStatus = SwitchStatus(key: 'testKey', value: true);

      final result = await switchUsecase.saveStatus(switchStatus);

      expect(result, true);
      expect(sharedPreferences.getBool('switch_status_v1_testKey'), true);
    });
  });
}
