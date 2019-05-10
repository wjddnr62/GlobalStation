import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

class DiamondD2 extends StatefulWidget {
  @override
  Diamond createState() => Diamond();
}

class Diamond extends State<DiamondD2> {
  String title = "Listen and choose the correct answer.";
  String question = "Did you use to _____ a gift when you visited someone's house?";

  final String diaQue = "assets/gamebox/img/speed/dia_ans.png";

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
            "assets/gamebox/img/speed/speed_dia_2.png",
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: size.height / 3.3,
            width: size.width - 20,
            child: Container(
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    "assets/gamebox/img/speed/dia_que2.png",
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    top: 30,
                    left: 55,
                    child: Container(
                      width: size.width - 100,
                      child:Center(
                        child: Text(
                          question,
                          style: titleTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
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
            top: size.height / 2.15,
            child: message(size),
          ),
          Positioned(
            bottom: 10,
            child: nextBtn(size),
          ),
        ],
      ),
    );
  }

  Widget message(Size size) {
    return Container(
      width: size.width - 20,
      height: 50,
      padding: const EdgeInsets.only(left:20),
      child: Stack(
        children: <Widget>[
          Image.asset(
            diaQue,
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
                  hintText: "___",
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
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
