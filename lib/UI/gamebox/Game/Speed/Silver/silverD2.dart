import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/bloc/speed_game_bloc.dart';
import 'package:lms_flutter/theme.dart';

String answer = "";

//class SilverD2 extends StatefulWidget {
//
//  final String level;
//  final int chapter;
//  final int stage;
//  final int question_num;
//  final String title;
//  final String question;
//
//  SilverD2({Key key, this.level, this.chapter, this.stage, this.question_num,this.title,
//    this.question})
//      : super(key: key);
//
//  @override
//  Silver createState() => Silver();
//}
//
//class Silver extends State<SilverD2> {
////  String title = "Listen and choose the correct answer.";
////  String question = "Is Tom _____?";
//
//  final String silverWood = "assets/gamebox/img/speed/sliver_ans.png";
//
//  @override
//  Widget build(BuildContext context) {
//    return body(MediaQuery.of(context).size);
//  }
//
//  Widget body(Size size) {
//    return Container(
//      width: size.width,
//      height: size.height,
//      child: Stack(
//        children: <Widget>[
//          Image.asset(
//            "assets/gamebox/img/speed/speed_silver_1.png",
//            width: size.width,
//            height: size.height,
//            fit: BoxFit.cover,
//          ),
//          Positioned(
//            top: size.height / 3.1,
//            width: size.width - 20,
//            child: Container(
//              child: Stack(
//                children: <Widget>[
//                  Image.asset(
//                    "assets/gamebox/img/speed/silver_que2.png",
//                    fit: BoxFit.contain,
//                  ),
//                  Positioned(
//                    top: 32,
//                    left: 55,
//                    child: Container(
//                      width: size.width - 100,
//                      child:Center(
//                        child: Text(
//                          widget.question,
//                          style: titleTextStyle,
//                        ),
//                      ),
//                    ),
//                  )
//                ],
//              ),
//            ),
//          ),
//          Positioned(
//            top: size.height / 3.7,
//            child: Container(
//              width: size.width,
//              child: Center(
//                child: Text(
//                  widget.title,
//                  style: titleTextStyle,
//                ),
//              ),
//            ),
//          ),
//          Positioned(
//            top: size.height / 2.2,
//            child: wood("A", "___", size),
//          ),
//
//        ],
//      ),
//    );
//  }
//
//  Widget wood(String type, String text, Size size) {
//    return Container(
//      width: size.width - 20,
//      height: 50,
//      padding: const EdgeInsets.symmetric(horizontal: 10),
//      child: InkWell(
//        onTap: (){
////          speedBloc.answerA = answer;
//          speedBloc.answerType = 2;
//        },
//        child: Stack(
//          children: <Widget>[
//            Container(
//              width: double.infinity,
//              height: double.infinity,
//              decoration: BoxDecoration(
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.black38,
//                      offset: Offset(4.0,4.0),
//                    )
//                  ]
//              ),
//            ),
//            Image.asset(
//              silverWood,
//              width: size.width - 20,
//              height: 50,
//              fit: BoxFit.fill,
//            ),
//            Align(
//              alignment: AlignmentDirectional.center,
//              child: Padding(
//                padding: const EdgeInsets.only(left: 40),
//                child: TextField(
//                  decoration: InputDecoration(
//                    focusedBorder: InputBorder.none,
//                    enabledBorder: InputBorder.none,
//                  ),
//                  onChanged: (value){speedBloc.answerA = value;},
//                ),
//              ),
//            ),
////            Align(
////                alignment: AlignmentDirectional.centerStart,
////                child: Padding(
////                  padding: const EdgeInsets.only(left: 20),
////                  child: Text(type+")"),
////                )
////            )
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget nextBtn(Size size) {
//    return Container(
//      width: size.width,
//      height: 50,
//      child: Center(
//        child: Image.asset(
//          "assets/gamebox/img/next_btn.png",
//          width: 100,
//          height: 50,
//        ),
//      ),
//    );
//  }
//}
class SilverD2 extends StatelessWidget{
    final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;
  final String question;
    final AudioPlayer audioPlayer, background;

  SilverD2({Key key, this.level, this.chapter, this.stage, this.question_num,this.title,
    this.question, this.audioPlayer, this.background})
      : super(key: key);

  final String silverWood = "assets/gamebox/img/speed/sliver_ans.png";

    Timer _timer;
    String soundUrl;

    playSound(
        String level, String chapter, String stage, String question_num) async {
      print("phonicsB_play");

      audioPlayer.release();
        _timer = Timer(Duration(seconds: 1), () {
          if (soundUrl !=
              "http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}") {
            audioPlayer.setUrl(
                "http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}");
            audioPlayer.resume();
            soundUrl =
            "http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}";
          }
        });

      audioPlayer.onPlayerStateChanged.listen((state) {
        if (state == AudioPlayerState.COMPLETED) {
          background.setVolume(1.0);
        }
      });
    }



  @override
  Widget build(BuildContext context) {
    speedBloc.answerType = 2;
    background.setVolume(0.5);
    playSound(level, chapter.toString(),
        stage.toString(), question_num.toString());
    return body(MediaQuery.of(context).size,context);
  }

  Widget body(Size size,context) {
    final bool iphonex = MediaQuery.of(context).size.height >= 812.0;

    return Container(
      width: size.width,
      height: (iphonex) ? size.height - 97 : size.height - 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: <Widget>[
          Image.asset(
            "assets/gamebox/img/speed/speed_silver_1.png",
            width: size.width,
            height: size.height,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: size.height / 3.1,
            width: size.width - 20,
            child: Container(
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    "assets/gamebox/img/speed/silver_que2.png",
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    top: 32,
                    left: 55,
                    child: Container(
                      width: size.width - 100,
                      child:Center(
                        child: Text(
                          question,
                          style: speedSilverQuestionStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height / 3.7,
            child: Container(
              width: size.width,
              child: Center(
                child: Text(
                  title,
                  style: speedSilverTitleText,
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height / 2.2,
            child: wood("A", "___", size),
          ),

        ],
      ),
    );
  }



  Widget wood(String type, String text, Size size) {
    final TextEditingController controller = new TextEditingController();
    final FocusNode focus = FocusNode();
    return Container(
      width: size.width - 20,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child:  Stack(
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
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: new TextField(
                  focusNode: focus,
                  controller: controller,
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  onChanged: (value){speedBloc.answerA = value;},
                ),
              ),
            ),
          ],
        ),
    );
  }

}
