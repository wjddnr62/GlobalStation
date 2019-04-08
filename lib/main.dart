import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(Main());
}

class Main extends StatefulWidget {
  _MainState createState() => new _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
        child: SafeArea(
          child: new Material(
            child: new Container(
              decoration: new BoxDecoration(color: Color(0xFFFFFFFF)),
              child: new Form(
                child: new Container(

                ),
                onWillPop: () {
                  return null;
                },
              ),
            ),
          )
        ),
    );
  }
}
