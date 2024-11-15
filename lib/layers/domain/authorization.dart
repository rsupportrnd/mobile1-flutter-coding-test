
/// 계정 클래스
class Authorization{
  late String userId;
  late String name;
  late String email;
  late String profileImageURL;
  late String role;

  /// 한번 초기화로 계속 사용할 수 있다.
  static final Authorization _authInstance = Authorization.internal();

  factory Authorization(){
    return _authInstance;
  }

  Authorization.internal() {
     userId = 'psw2575';
     name = 'Sangwon Park';
     email = 'tkddnjs2575@gmail.com';
     profileImageURL ='https://picsum.photos/id/1011/200/200';
     role = 'member';
  }

}