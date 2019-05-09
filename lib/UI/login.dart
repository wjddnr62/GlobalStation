import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lms_flutter/api_call.dart';
import 'package:lms_flutter/UI/main.dart';
import '../bloc/login_bloc.dart';

class Login extends StatefulWidget {
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {

  void ttt(){
    bloc.submit().then((value){

    }).catchError((error){

    });
  }


  bool _obscureText = true;
  bool _isLogin = false;

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

  Widget body(buildContext) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xFFFCCA20),
      body: new Container(
        child: new Container(
          margin: new EdgeInsets.only(left: 30.0, right: 30.0),
          child: new Center(
            child: new Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Padding(padding: EdgeInsets.only(top: 130.0)),
                Image.asset(
                  'assets/logo/icon_logo.png',
                  width: 150,
                  height: 100,
                ),
                new Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 35.0),
                        child: new TextFormField(
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
                                } else if (json.decode(result)['result'] == 1) {
                                  _idController.text = "";
                                  _passController.text = "";
                                  Navigator.push(
                                      mainContext,
                                      MaterialPageRoute(
                                          builder: (context) => Main(result)));
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    mainContext = context;
    return body(context);
  }
}
