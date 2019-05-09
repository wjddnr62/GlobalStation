import 'package:lms_flutter/model/user.dart';

class UserInfo{
  static final UserInfo _userInfo = new UserInfo._internal();

  factory UserInfo() {
    return _userInfo;
  }

  UserInfo._internal();

   String _child_key;
   String _child_user_id;
   String _user_id; // 부모 아이디
   String _child_name;
   List<User> _userData;

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
  } // 학생 이름



}