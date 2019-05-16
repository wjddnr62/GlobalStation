import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms_flutter/UI/login.dart';
import 'package:lms_flutter/UI/main.dart';
import 'route.dart';


void main() {
//  SystemChrome.setEnabledSystemUIOverlays([]);
//  debugPaintLayerBordersEnabled = true;
//  debugPaintSizeEnabled = true;
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "LMS Splash Page",
    home: new SplashScreen(),
//    routes: <String, WidgetBuilder>{
//      '/Login': (BuildContext context) => Login(),
//      '/Main': (BuildContext context) => Main(),
//    },
  routes: routes,
  ));
}

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Login');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  Widget body() {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: new Container(
        child: new Container(
          child: new Center(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: Image.asset('assets/splash/icon_splash.png',),
                  )
                ]
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
