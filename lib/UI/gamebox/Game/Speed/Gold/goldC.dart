import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

class GoldC extends StatefulWidget {
  @override
  Gold createState() => Gold();
}

class Gold extends State<GoldC> {
  String title = "Listen and choose the correct answer.";
  String question = "Good morning. How are You?";

  final String goldBrick = "assets/gamebox/img/speed/brick.png";

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
            "assets/gamebox/img/speed/speed_gold_1.png",
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),


          Positioned(
            top: size.height / 7.5,
            width: size.width - 20,
            child: Container(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:Image.asset(
                      "assets/gamebox/img/speed/gold_que1.png",
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
            top: size.height / 2.6,
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
            top: size.height / 2.25,
            child: brick("A", size),
          ),
          Positioned(
            top: size.height / 1.78,
            child: brick( "B", size),
          ),
          Positioned(
            top: size.height / 1.48,
            child: brick("C", size),
          ),
          Positioned(
            top: size.height / 1.26,
            child: brick("D", size),
          ),
          Positioned(
            bottom: 10,
            child: nextBtn(size),
          ),
        ],
      ),
    );
  }

  Widget brick(String text, Size size) {
    return Container(
      width: size.width - 20,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: <Widget>[
          Image.asset(
            goldBrick,
            width: size.width - 20,
            height: 70,
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
