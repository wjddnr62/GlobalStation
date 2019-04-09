import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lms_flutter/main.dart';

void main() {
//  SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'LMS Login Page',
    home: new Login(),
    routes: <String, WidgetBuilder>{
      '/Main': (BuildContext context) => Main(),
    },
  ));
}

class Login extends StatefulWidget {
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  String _password;

  final FocusNode _idFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();

  void _passwordtoggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _loginButton() {
    Fluttertoast.showToast(
      msg: "로그인",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
    );
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Main()),);
//    Navigator.of(context).pushReplacementNamed('/Main');
  }

  Widget body() {
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
                Image.asset('assets/logo/icon_logo.png', width: 150, height: 100,),
                new Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 35.0),
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "아이디",
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
                          decoration: new InputDecoration(
                            labelText: "비밀번호",
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
                            onPressed: () {
                              _loginButton();
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
    return body();
  }
}
