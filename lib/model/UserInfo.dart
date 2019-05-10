import 'package:lms_flutter/model/user.dart';

class UserInfo{
  static final UserInfo _userInfo = new UserInfo._internal();

  factory UserInfo() {
    return _userInfo;
  }

  UserInfo._internal();

   //로그인 시 받는 데이터
   String _child_key;
   String _child_user_id;
   String _user_id; // 부모 아이디
   String _child_name; // 학생 이름

   //계정 선택 시 사용 할 리스트 데이터
   List<User> _userData;

   //로그인 후 계정 연결 된 유저 데이터
   int _member_coin;
   int _member_level;

   List<String> _levelList;

  List<String> get levelList => _levelList;

  set levelList(List<String> value) {
    _levelList = value;
  }

  List<User> get userData => _userData;

  set userData(List<User> value) {
    _userData = value;
  }

  String get child_key => _child_key;

  String get child_name => _child_name;

  set child_name(String value) {
    _child_name = value;
  }

  String get user_id => _user_id;

  set user_id(String value) {
    _user_id = value;
  }

  String get child_user_id => _child_user_id;

  set child_user_id(String value) {
    _child_user_id = value;
  }

  set child_key(String value) {
    _child_key = value;
  }

  int get member_level => _member_level;

  set member_level(int value) {
    _member_level = value;
  }

  int get member_coin => _member_coin;

  set member_coin(int value) {
    _member_coin = value;
  }


}