import 'package:flutter_test/flutter_test.dart';
import 'package:rs_flutter_test/main_ex.dart';
import 'package:rs_flutter_test/util/r_color.dart';

void main() {
  late MainViewModel vm;
  setUp(() {
    vm = MainViewModel();
  });

  group('MainViewModel Test', () {
    test('기본값 확인', () {
      expect(vm.status1, false);
      expect(vm.status2, false);
      expect(vm.status3, false);
      expect(vm.status4, false);
      expect(vm.status5, false);
      expect(vm.status6, false);
      expect(vm.status7, false);
      expect(vm.status8, false);
      expect(vm.isSwitchOn, false);

      expect(vm.textColor, RsupportColor.black_01);
      expect(vm.appBarColor, RsupportColor.black_02);
      expect(vm.bgColor, RsupportColor.white_01);
    });

    test('변수 값 변경 확인 - set()', () {
      vm.setStatus1(false);
      expect(vm.status1, false);
      vm.setStatus1(true);
      expect(vm.status1, true);

      vm.setStatus2(false);
      expect(vm.status2, false);
      vm.setStatus2(true);
      expect(vm.status2, true);

      vm.setStatus3(false);
      expect(vm.status3, false);
      vm.setStatus3(true);
      expect(vm.status3, true);

      vm.setStatus4(false);
      expect(vm.status4, false);
      vm.setStatus4(true);
      expect(vm.status4, true);

      vm.setStatus5(false);
      expect(vm.status5, false);
      vm.setStatus5(true);
      expect(vm.status5, true);

      vm.setStatus6(false);
      expect(vm.status6, false);
      vm.setStatus6(true);
      expect(vm.status6, true);

      vm.setStatus7(false);
      expect(vm.status7, false);
      vm.setStatus7(true);
      expect(vm.status7, true);

      vm.setStatus8(false);
      expect(vm.status8, false);
      vm.setStatus8(true);
      expect(vm.status8, true);

      vm.setSwitchOn(false);
      expect(vm.isSwitchOn, false);
      vm.setSwitchOn(true);
      expect(vm.isSwitchOn, true);
    });

    test('다크테마 or 라이트테마 색 변경 값 확인', () {
      vm.setStatus7(true);
      expect(vm.textColor, RsupportColor.dartThemeText);
      expect(vm.appBarColor, RsupportColor.dartThemeAppBar);
      expect(vm.bgColor, RsupportColor.dartThemeBg);

      vm.setStatus7(false);
      expect(vm.textColor, RsupportColor.lightThemeText);
      expect(vm.appBarColor, RsupportColor.lightThemeAppBar);
      expect(vm.bgColor, RsupportColor.lightThemeBg);
    });
  });
}
