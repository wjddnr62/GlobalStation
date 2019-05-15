import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

class DiamondD1 extends StatefulWidget {
  @override
  Diamond createState() => Diamond();
}

class Diamond extends State<DiamondD1> {
  String title = "Listen and choose the correct answer.";
  String question = "How is Dave doing with his ____ ____?";

  final String diamondMessage = "assets/gamebox/img/speed/message.png";

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(
                      "assets/gamebox/img/speed/dia_que2.png",
                      fit: BoxFit.contain,
                    ),
                  ),

                  Positioned(
                    top: 35,
                    left: 50,
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
            top: size.height / 4.2,
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
            top: size.height / 2,
            child: message("A", "debate contents", size),
          ),
          Positioned(
            top: size.height / 1.7,
            child: message("B", "debate contest", size),
          ),
          Positioned(
            top: size.height / 1.48,
            child: message("C", "debating contest", size),
          ),
          Positioned(
            top: size.height / 1.31,
            child: message("D", "debating contents", size),
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
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: <Widget>[
          Image.asset(
            diamondMessage,
            width: size.width - 20,
            height: 50,
            fit: BoxFit.fill,
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Text(text),
          ),
          Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(type),
              )
          )
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
