
import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/common.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';

class UserListViewModel extends ChangeNotifier {

  /// state variables
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';

  /// state getter
  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  /// 사용자 리스트
  List<User> _userList = [];
  List<User> get userList => _userList;

  UserListViewModel() {
    fetchUserList();
  }

  /// 서버로부터 사용자 리스트를 가져옵니다.
  Future<void> fetchUserList() async {
    try {
      final users = await FetchUsersUseCase().execute();
      _userList = List.from(users);
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

  /// 사용자 리스트를 다시 가져오기 위해 호출됩니다.
  onRetry() {
    _isLoading = true;
    _isError = false;
    _userList.clear();
    notifyListeners();

    fetchUserList();
  }

  /// 오류 발생 시 오류 상태와 메시지를 업데이트합니다.
  notifyError(String errorMsg) {
    _isLoading = false;
    _isError = true;
    _errorMessage = errorMsg;
    notifyListeners();
  }
}