import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lms_flutter/route.dart';
import 'package:lms_flutter/theme.dart';
import 'package:http/http.dart' as http;

class BookBox extends StatefulWidget {

  _BookBoxState createState() => new _BookBoxState();
}

class _BookBoxState extends State<BookBox> {



  Widget appBar() {
    return AppBar(
      backgroundColor: Color(bookboxmainColor),
      title: Row(
        children: <Widget>[
          Text("Book Box", style: TextStyle(fontSize: defaultFontSize, color: Colors.white),)
        ],
      )
    );
  }

  Widget mainBody() {
    return Container(
      child: Scaffold(
        backgroundColor: Color(WhiteColor),
        appBar: AppBar(),
        drawer: SizedBox(
          width: double.infinity,
//          child: drawer(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return mainBody();
  }

}
