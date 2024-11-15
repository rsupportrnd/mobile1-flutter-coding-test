
import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/common.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';

class MeetingRoomListViewModel extends ChangeNotifier {

  /// state variables
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';

  /// state getter
  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  /// 회의 목록
  List<MeetingRoom> _meetingRoomList = [];
  List<MeetingRoom> get meetingRoomList => _meetingRoomList;

  /// 회의목록 리스트를 가져오기 위한 UseCase
  final FetchMeetingRoomUseCase _useCase;

  MeetingRoomListViewModel([FetchMeetingRoomUseCase? useCase]) : _useCase = useCase ?? locator();


  /// 서버로부터 회의 목록을 가져옵니다.
  Future<void> fetchMeetingRoomList() async {
    print('fetchMeetingRoomList 호출');
    try {
      final users = await _useCase.execute();
      _meetingRoomList = List.from(users);
    }
    /// DioException이 발생하면 DioExceptions 클래스를 사용하여 오류를 처리 제외
    //on DioException catch (e) {
    //final msg = DioExceptions.fromDioError(e).toString();
    //notifyError(msg);
    //}
    catch(e) {
      notifyError(AppStrings.unexpectedError);
    }
    finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 회의 리스트를 다시 가져오기 위해 호출됩니다.
  onRetry() {
    _isLoading = true;
    _isError = false;
    _meetingRoomList.clear();
    notifyListeners();

    fetchMeetingRoomList();
  }

  /// 오류 발생 시 오류 상태와 메시지를 업데이트합니다.
  notifyError(String errorMsg) {
    _isLoading = false;
    _isError = true;
    _errorMessage = errorMsg;
    notifyListeners();
  }
}