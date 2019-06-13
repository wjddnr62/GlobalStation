import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/bloc/speed_game_bloc.dart';
import 'package:lms_flutter/theme.dart';

String answer = "";

class SilverD2 extends StatefulWidget{
    final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;
  final String question;
    final AudioPlayer audioPlayer, background;
    final TextEditingController controller;

  SilverD2({Key key, this.level, this.chapter, this.stage, this.question_num,this.title,
    this.question, this.audioPlayer, this.background, this.controller})
      : super(key: key);

  @override
  Silver createState() => Silver();

}

class Silver extends State<SilverD2> {

  final String silverWood = "assets/gamebox/img/speed/sliver_ans.png";

  AudioPlayer advancedPlayer, background;
  Timer _timer;
  String soundUrl, soundUrl2;
  bool soundFinish = false;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    advancedPlayer = widget.audioPlayer;
    background = widget.background;
    controller = widget.controller;
  }

  playSound(
      String level, String chapter, String stage, String question_num) async {
    print("phonicsB_play");

    advancedPlayer.release();
    if (soundUrl2 !=
        "http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}") {
      soundFinish = false;
      soundUrl2 = "http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}";
    }
        _timer = Timer(Duration(milliseconds: 500), () {
    if (soundUrl !=
        "http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}") {
      advancedPlayer.setUrl(
          "http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}");
      advancedPlayer.resume();
      soundUrl =
      "http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}";
    }
        });

    advancedPlayer.onPlayerStateChanged.listen((state) {
      if (state == AudioPlayerState.COMPLETED) {
        background.setVolume(1.0);
        setState(() {
          soundFinish = true;
        });
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    speedBloc.answerType = 2;
    background.setVolume(0.5);
    playSound(widget.level, widget.chapter.toString(),
        widget.stage.toString(), widget.question_num.toString());
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
                          widget.question,
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
                  widget.title,
                  style: speedSilverTitleText,
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height / 2.2,
            child: wood("A", "___", size),
          ),
          soundFinish ? Container(
            width: 0,
            height: 0,
          ) : Positioned(
            top: size.height / 2.2,
            child: Container(
              width: size.width - 20,
              height: 50,
              color: Colors.transparent,
            ),
          )

        ],
      ),
    );
  }



  Widget wood(String type, String text, Size size) {
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
