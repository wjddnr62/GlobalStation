import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

class DiamondC extends StatefulWidget {
  @override
  Diamond createState() => Diamond();
}

class Diamond extends State<DiamondC> {
  String title = "Listen and choose the correct answer.";
  String question = "can you and Jason ___ Well?";

  final String diamondMessage = "assets/gamebox/img/speed/message.png";

  @override
  Widget build(BuildContext context) {

    return body(MediaQuery.of(context).size);
  }

  Widget body(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: <Widget>[
          Image.asset(
            "assets/gamebox/img/speed/speed_dia_1.png",
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),


          Positioned(
            top: size.height / 6,
            width: size.width - 20,
            child: Container(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:Image.asset(
                      "assets/gamebox/img/speed/dia_que.png",
                      fit: BoxFit.contain,
                    ),
                  ),

                  Positioned(
                    top: 25,
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
            top: size.height / 2.5,
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
            child: message("A", size),
          ),
          Positioned(
            top: size.height / 1.7,
            child: message( "B", size),
          ),
          Positioned(
            top: size.height / 1.48,
            child: message("C", size),
          ),
          Positioned(
            top: size.height / 1.31,
            child: message("D", size),
          ),
          Positioned(
            bottom: 10,
            child: nextBtn(size),
          ),
        ],
      ),
    );
  }

  Widget message(String text, Size size) {
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
