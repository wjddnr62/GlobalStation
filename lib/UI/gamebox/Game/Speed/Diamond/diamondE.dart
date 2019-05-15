import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

class DiamondE extends StatefulWidget {
  @override
  Diamond createState() => Diamond();
}

class Diamond extends State<DiamondE> {
  String title = "Listen and choose the correct answer.";

  final String diaMessage = "assets/gamebox/img/speed/dia_ans.png";

  @override
  Widget build(BuildContext context) {
    print(11);
    return body(MediaQuery.of(context).size);
  }

  Widget body(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: <Widget>[
          Image.asset(
            "assets/gamebox/img/speed/speed_dia_4.png",
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: size.height / 4.3,
            child: Container(
              width: size.width,
              child: Center(
                child: Text(
                  title,
                  style: titleTextStyle,
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height / 2.2,
            child: message("A", "___", size),
          ),
          Positioned(
            bottom: 10,
            child: nextBtn(size),
          ),
        ],
      ),
    );
  }

  Widget message(String type, String text, Size size) {
    return Container(
      width: size.width - 20,
      height: 50,
      padding: const EdgeInsets.only(left: 40,right: 10),
      child: Stack(
        children: <Widget>[
          Image.asset(
            diaMessage,
            width: size.width - 20,
            height: 50,
            fit: BoxFit.fill,
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "_______________________",
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
//          Align(
//              alignment: AlignmentDirectional.centerStart,
//              child: Padding(
//                padding: const EdgeInsets.only(left: 20),
//                child: Text(type+")"),
//              )
//          )
        ],
      ),
    );
  }

  Widget nextBtn(Size size) {
    return Container(
      width: size.width,
      height: 50,
      child: Center(
        child: Image.asset(
          "assets/gamebox/img/next_btn.png",
          width: 100,
          height: 50,
        ),
      ),
    );
  }
}
