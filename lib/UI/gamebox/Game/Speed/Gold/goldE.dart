import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

class GoldE extends StatefulWidget {
  @override
  Gold createState() => Gold();
}

class Gold extends State<GoldE> {
  String title = "Listen and choose the correct answer.";

  final String silverWood = "assets/gamebox/img/speed/sliver_ans.png";

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
            "assets/gamebox/img/speed/speed_gold_4.png",
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: size.height / 4,
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
            child: answer(size),
          ),
          Positioned(
            bottom: 10,
            child: nextBtn(size),
          ),
        ],
      ),
    );
  }

  Widget answer(Size size) {
    return Container(
      width: size.width - 20,
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "_____________________",
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Colors.transparent,

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
