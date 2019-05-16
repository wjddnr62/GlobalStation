import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

class SilverC extends StatefulWidget {

  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;
  final String question;

  SilverC({Key key, this.level, this.chapter, this.stage, this.question_num,this.title,
    this.question})
      : super(key: key);

  @override
  Silver createState() => Silver();
}

class Silver extends State<SilverC> {
//  String title = "Listen and choose the correct answer.";
//  String question = "Is Tom _____?";

  final String silverWood = "assets/gamebox/img/speed/wood.png";

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
            "assets/gamebox/img/speed/speed_silver_5.png",
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
                    "assets/gamebox/img/speed/silver_que2.png",
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: size.height / 5.5,
            width: size.width - 20,
            child: Container(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:Image.asset(
                      "assets/gamebox/img/speed/silver_que1.png",
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
                          widget.question,
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
            top: size.height / 2.4,
            child: Container(
              width: size.width,
              child: Center(
                child: Text(
                  widget.title,
                  style: titleTextStyle,
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height / 2.2,
            child: wood("A", size),
          ),
          Positioned(
            top: size.height / 1.83,
            child: wood( "B", size),
          ),
          Positioned(
            top: size.height / 1.56,
            child: wood("C", size),
          ),
          Positioned(
            top: size.height / 1.36,
            child: wood("D", size),
          ),
          Positioned(
            bottom: 10,
            child: nextBtn(size),
          ),
        ],
      ),
    );
  }

  Widget wood(String text, Size size) {
    return Container(
      width: size.width - 20,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(4.0,4.0),
                  )
                ]
            ),
          ),
          Image.asset(
            silverWood,
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
