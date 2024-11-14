import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/main/main_frame_viewmodel.dart';

void main (){
  group('MainFrameViewModel Tests', (){
    late MainFrameViewModel mainFrameViewModel;

    setUp((){
      mainFrameViewModel = MainFrameViewModel();
    });

    test('초기 selectedIndex 값은 0이어야 한다', (){
      expect(mainFrameViewModel.selectedIndex, 0);
    });

    test('selectedIndex 값이 업데이트 되어야 한다', (){
      mainFrameViewModel.onItemTapped(1);
      expect(mainFrameViewModel.selectedIndex, 1);
    });
  });
}