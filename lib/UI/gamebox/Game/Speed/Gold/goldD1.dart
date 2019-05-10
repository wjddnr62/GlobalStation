import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

class GoldD1 extends StatefulWidget {
  @override
  Gold createState() => Gold();
}

class Gold extends State<GoldD1> {
  String title = "Listen and choose the correct answer.";
  String question = "Christina will bring some French Fries to the ________ _____ next week.";

  final String glodBrick = "assets/gamebox/img/speed/brick.png";

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
            "assets/gamebox/img/speed/speed_gold_2.png",
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
                      "assets/gamebox/img/speed/gold_que2.png",
                      fit: BoxFit.contain,
                    ),
                  ),

                  Positioned(
                    top: 20,
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
            top: size.height / 2.25,
            child: brick("A", "backyard party", size),
          ),
          Positioned(
            top: size.height / 1.78,
            child: brick("B", "burthday party", size),
          ),
          Positioned(
            top: size.height / 1.48,
            child: brick("C", "farewekk party", size),
          ),
          Positioned(
            top: size.height / 1.26,
            child: brick("D", "housewarming party", size),
          ),
          Positioned(
            bottom: 10,
            child: nextBtn(size),
          ),
        ],
      ),
    );
  }

  Widget brick(String type, String text, Size size) {
    return Container(
      width: size.width - 20,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: <Widget>[
          Image.asset(
            glodBrick,
            width: size.width - 20,
            height: 70,
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
