import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

class BronzeB extends StatefulWidget {
  @override
  Bronze createState() => Bronze();
}

class Bronze extends State<BronzeB> {
  String title = "Listen and choose the correct picture.";

  final String A_POSTIT = "assets/gamebox/img/speed/postitA.png";
  final String B_POSTIT = "assets/gamebox/img/speed/postitB.png";

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
            "assets/gamebox/img/speed/speed_bronze_1.png",
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: size.height / 3.5,
            child: Container(
              width: size.width,
              child: Center(child: Text(title,style: titleTextStyle,),),
            ),
          ),

          Positioned(
            left: 20,
            top: size.height / 2.5,
            child: postIt("A", "test1"),
          ),
          Positioned(
            right: 20,
            top: size.height / 2.5,
            child: postIt("B", "test1"),
          ),
          Positioned(
            left: 20,
            top: size.height / 1.6,
            child: postIt("B", "test1"),
          ),
          Positioned(
            right: 20,
            top: size.height / 1.6,
            child: postIt("A", "test1"),
          ),
        ],
      ),
    );
  }

  Widget postIt(String type, String text) {
    return Container(
      width: 150,
      height: 150,
      child: Stack(
        children: <Widget>[
          Image.asset(
            (type == "A") ? A_POSTIT : B_POSTIT,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }

  Widget nextBtn(Size size) {
    return Container(
      width: size.width,
      height: 55,
      child: Image.asset(
        "assets/gamebox/img/next_btn.png",
        width: 100,
        height: 55,
      ),
    );
  }


}
