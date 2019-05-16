import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

class BronzeC extends StatefulWidget {

  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;
  final String question;

  BronzeC({Key key, this.level, this.chapter, this.stage, this.question_num,this.title,
  this.question})
      : super(key: key);

  @override
  Bronze createState() => Bronze();
}

class Bronze extends State<BronzeC> {
//  String title = "Listen and choose the correct answer.";
//  String question = "Good morning. How are You?asdkgafasd";

  final String C_POSTIT = "assets/gamebox/img/speed/postitC.png";
  final String D_POSTIT = "assets/gamebox/img/speed/postitD.png";

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
            "assets/gamebox/img/speed/speed_bronze_2.png",
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: size.height / 5.5,
            width: size.width - 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    "assets/gamebox/img/speed/bronze_que.png",
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    top: 23,
                    left: 50,
                    child: Container(
                      width: size.width - 100,
                      height: 30,
                      child: Text(widget.question,style: titleTextStyle,),
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
            top: size.height / 2.15,
            child: postIt("D", "A", size),
          ),
          Positioned(
            top: size.height / 1.78,
            child: postIt("C", "B", size),
          ),
          Positioned(
            top: size.height / 1.52,
            child: postIt("D", "C", size),
          ),
          Positioned(
            top: size.height / 1.33,
            child: postIt("C", "D", size),
          ),
          
//          Positioned(
//            bottom: 10,
//            child: nextBtn(size),
//          ),
        ],
      ),
    );
  }

  Widget postIt(String type, String text, Size size) {
    return Container(
      width: size.width - 20,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: <Widget>[
          Image.asset(
            (type == "C") ? C_POSTIT : D_POSTIT,
            width: size.width - 20,
            height: 50,
            fit: BoxFit.cover,
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
      child: Image.asset(
        "assets/gamebox/img/next_btn.png",
        width: 100,
        height: 50,
      ),
    );
  }
}
