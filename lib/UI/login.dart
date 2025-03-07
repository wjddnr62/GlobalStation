import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lms_flutter/UI/main.dart';
import 'package:lms_flutter/api_call.dart';
import 'package:lms_flutter/model/UserInfo.dart';
import 'package:lms_flutter/model/user.dart';
import 'package:lms_flutter/bloc/member_bloc.dart';

import '../bloc/login_bloc.dart';

class Login extends StatefulWidget {
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  UserInfo userInfo = UserInfo();

  var member_name = "";
  var member_id = "";
  var member_coin = 0;
  var member_level = 0;
  List<User> users;
  List<DetailUser> detailUser;
  List<String> level_list = new List();

  void login() async {
    bloc.submit().then((value) async {
      print("value : " + value);
      List<User> userData = json
          .decode(value)['data']
          .map<User>((json) => User.fromJson(json))
          .toList();
      if (userData.length == 1) {
        userInfo.child_key = userData[0].child_key;
        userInfo.child_name = userData[0].child_name;
        userInfo.child_user_id = userData[0].child_user_id;
        userInfo.user_id = userData[0].user_id;
        print("1");
      } else if (userData.length == 2) {
        userInfo.userData = userData.cast<User>();
        userInfo.child_key = userData[0].child_key;
        userInfo.child_name = userData[0].child_name;
        userInfo.child_user_id = userData[0].child_user_id;
        userInfo.user_id = userData[0].user_id;
        print("2");
      }
    }).catchError((error) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(error),
      ));
      _isLogin = false;
      print("error : " + error);
    });
  }

  bool _obscureText = true;
  bool _isLogin = true;

  bool _nextPage = false;

  String _password;

  final FocusNode _idFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();

  final _idController = TextEditingController();
  final _passController = TextEditingController();

  BuildContext mainContext;

  void _passwordtoggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void setUserData(String data) async {
    level_list.add("Phonics 1");
    level_list.add("Phonics 2");
    level_list.add("Phonics 3");
    level_list.add("Bronze 1");
    level_list.add("Bronze 2");
    level_list.add("Bronze 3");
    level_list.add("Silver 1");
    level_list.add("Silver 2");
    level_list.add("Silver 3");
    level_list.add("Gold 1");
    level_list.add("Gold 2");
    level_list.add("Gold 3");
    level_list.add("Diamond 1");
    level_list.add("Diamond 2");
    level_list.add("Diamond 3");

    userInfo.levelList = level_list;

    users = json.decode(data)['data'].map<User>((json) => User.fromJson(json)).toList();

    member_id = users[0].user_id;
    member_name = users[0].child_name;

    Api_Call().fetchDetailUser(http.Client(), json.decode(data)['data'][0]['child_key']).then((result) async{
      setState(() {
        member_coin = json.decode(result)['data']['coin'];
        member_level = json.decode(result)['data']['level'] - 1;
      });
    });

    mbloc.changeuserno(json.decode(data)['data'][0]['child_key']);
    mbloc.getMember().then((value) {
      userInfo.member_coin = json.decode(value)['data']['coin'];
      userInfo.member_level = json.decode(value)['data']['level'] - 1;
    });
  }

  Widget body(buildContext) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFFCCA20),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 150.0, left: 30.0, right: 30.0, bottom: 0.0),
                child: new Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/logo/icon_logo.png',
                          width: 150,
                          height: 100,
                        ),
                      ),
//                Padding(padding: EdgeInsets.only(top: 130.0)),
//                Image.asset(
//                  'assets/logo/icon_logo.png',
//                  width: 150,
//                  height: 100,
//                ),

                      Container(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 35.0),
                              child: TextFormField(
                                controller: _idController,
                                decoration: new InputDecoration(
                                  hintText: "아이디",
                                  labelStyle: TextStyle(color: Color(0xFF969696)),
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: new Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Image.asset(
                                      'assets/login/icon_id.png',
                                      width: 30.0,
                                      height: 30.0,
                                    ),
                                  ),
                                  border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                    borderSide:
                                    new BorderSide(color: Color(0xFF969696)),
                                  ),
                                ),
                                focusNode: _idFocus,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (v) {
                                  _idFocus.unfocus();
                                  FocusScope.of(context).requestFocus(_passFocus);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: new TextFormField(
                                controller: _passController,
                                decoration: new InputDecoration(
                                  hintText: "비밀번호",
                                  labelStyle: TextStyle(color: Color(0xFF969696)),
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: new Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Image.asset(
                                      'assets/login/icon_password.png',
                                      width: 30.0,
                                      height: 30.0,
                                    ),
                                  ),
                                  suffixIcon: new IconButton(
                                      icon: new Icon(_obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: _passwordtoggle),
                                  border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                    borderSide:
                                    new BorderSide(color: Color(0xFF969696)),
                                  ),
                                ),
                                focusNode: _passFocus,
                                validator: (val) =>
                                val.length < 6 ? 'Password too short.' : null,
                                onSaved: (val) => _password = val,
                                obscureText: _obscureText,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 25.0),
                                child: new RaisedButton(
                                  onPressed: () async {
//                              print(_idController.text.isEmpty);
                                    if (_idController.text.isEmpty == true ||
                                        _passController.text.isEmpty == true) {
                                      Fluttertoast.showToast(
                                          msg: "아이디 또는 비밀번호를 입력해주세요.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM);
                                    } else {
                                      bloc.changeId(_idController.text);
                                      bloc.changePw(_passController.text);
                                      login();

                                      var result = await Api_Call().fetchUser(
                                          http.Client(),
                                          _idController.text,
                                          _passController.text);
                                      if (json.decode(result)['result'] == 0) {
                                        if (json
                                            .decode(result)['resultCode']
                                            .contains("user_not_found")) {
                                          Fluttertoast.showToast(
                                              msg: "아이디 또는 비밀번호가 틀립니다.",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM);
                                        } else if (json
                                            .decode(result)['resultCode']
                                            .contains("unknown")) {
                                          Fluttertoast.showToast(
                                              msg: "잠시 후 다시시도해주세요.",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM);
                                        }
                                      } else if (json.decode(result)['result'] ==
                                          1 && _isLogin == true) {
                                        _idController.text = "";
                                        _passController.text = "";
                                        setUserData(result);
                                        Navigator.of(context).pushNamed('/GameBox');
//                                        Navigator.push(
//                                            mainContext,
//                                            MaterialPageRoute(
//                                                builder: (context) =>
//                                                    Main(result)));
                                      } else if (_isLogin == false) {
                                        Fluttertoast.showToast(
                                            msg: "잠시 후 다시시도해주세요.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM);
                                      }
                                    }
                                  },
                                  textColor: Colors.black,
                                  colorBrightness: Brightness.light,
                                  color: Color(0xFFFFFFFF),
                                  child: new Text("로그인"),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    mainContext = context;
    return body(context);
  }
}
