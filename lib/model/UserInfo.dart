class UserInfo{
  static final UserInfo _userInfo = new UserInfo._internal();

  factory UserInfo() {
    return _userInfo;
  }

  UserInfo._internal();

}