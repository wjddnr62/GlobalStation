import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

class MatchPhonics extends StatefulWidget {
  @override
  Phonics createState() => Phonics();
}

class Phonics extends State<MatchPhonics> {
  String shell1Close = "assets/gamebox/img/match/shell_close.png";
  String shell1Open = "assets/gamebox/img/match/shell.png";

  String shell2Close = "assets/gamebox/img/match/shell2_close.png";
  String shell2Open = "assets/gamebox/img/match/shell2.png";

  Map<int, String> enDatas = {9: "book", 13: "cloud", 14: "cow"};

  Map<int, String> picDatas = {
    9: "/image/P/1/S1/book",
    13: "/image/P/1/S1/cloud",
    14: "/image/P/1/S1/book"
  };

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return body(MediaQuery.of(context).size);
  }

  Widget body(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height,
            child: Image.asset(
              "assets/gamebox/img/match/18.png",
              fit: BoxFit.fill,
              width: size.width,
              height: size.height,
            ),
          ),
          Positioned(
            top: size.width / 3.5,
            child: Container(
              width: size.width - 20,
              height: 360,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    "assets/gamebox/img/match/17.png",
                    width: size.width - 20,
                    height: 360,
                    fit: BoxFit.fill,
                  ),
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        rowData(1),
                        rowData(2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowData(int upDown) {
    return (upDown == 1)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              shell(1, false),
              shell(2, false),
              shell(1, false),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              shell(1, false),
              shell(2, false),
              shell(2, false),
            ],
          );
  }

  Widget shell(int type, bool isOpen) {
    return Container(
      child: Image.asset(
        (type == 1) ?
        shell1Close : shell2Close,
        fit: BoxFit.contain,
        width: 100,
        height: 100,
      ),
    );
  }
}
