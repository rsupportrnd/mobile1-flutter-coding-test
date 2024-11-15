

import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../domain/domain.dart';

class ChatViewModel extends ChangeNotifier {

  /// state variables
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';

  /// state getter
  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  List<ChatMessage> _chatMessageList = [];
  List<ChatMessage> get chatMessageList => _chatMessageList;


  /// 회의목록 리스트를 가져오기 위한 UseCase
  final FetchChatMessageUseCase _useCase;

  ChatViewModel([FetchChatMessageUseCase? useCase]) : _useCase = useCase ?? locator();

  Future<void> fetchChatMessageList() async {
    print('fetchChatMessageList 실행');
    try {
      final users = await _useCase.execute();
      _chatMessageList = List.from(users);

      for(var i  in _chatMessageList){
        print(i.messageId);
      }

    }
    /// DioException이 발생하면 DioExceptions 클래스를 사용하여 오류를 처리 제외
    //on DioException catch (e) {
    //final msg = DioExceptions.fromDioError(e).toString();
    //notifyError(msg);
    //}
    catch(e) {
      print(e);
      notifyError(AppStrings.unexpectedError);
    }
    finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void onChangedTextComposer(String value) {
    notifyListeners();
  }

  void sendMessage() {
  }


  /// 회의 리스트를 다시 가져오기 위해 호출됩니다.
  onRetry() {
    _isLoading = true;
    _isError = false;
    _chatMessageList.clear();
    notifyListeners();

    fetchChatMessageList();
  }

  /// 오류 발생 시 오류 상태와 메시지를 업데이트합니다.
  notifyError(String errorMsg) {
    _isLoading = false;
    _isError = true;
    _errorMessage = errorMsg;
    notifyListeners();
  }
}