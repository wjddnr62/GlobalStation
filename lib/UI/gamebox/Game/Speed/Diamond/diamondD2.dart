import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/bloc/speed_game_bloc.dart';
import 'package:lms_flutter/theme.dart';

String answer = "";

class DiamondD2 extends StatefulWidget {
  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;
  final String question;
  final AudioPlayer audioPlayer, background;
  final TextEditingController controller;

  DiamondD2(
      {Key key,
      this.level,
      this.chapter,
      this.stage,
      this.question_num,
      this.title,
      this.question,
      this.audioPlayer,
      this.background,
      this.controller})
      : super(key: key);

  @override
  Diamond createState() => Diamond();
}

class Diamond extends State<DiamondD2> {
//  String title = "Listen and choose the correct answer.";
//  String question = "Did you use to _____ a gift when you visited someone's house?";

  final String diaQue = "assets/gamebox/img/speed/dia_ans.png";

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer, background;
  Timer _timer;
  String soundUrl, soundUrl2;
  TextEditingController controller;
  bool soundFinish = false;

  playSound(
      String level, String chapter, String stage, String question_num) async {

      advancedPlayer.release();
      if (soundUrl2 !=
          "http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}") {
        soundFinish = false;
        soundUrl2 = "http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}";
      }
      _timer = Timer(Duration(milliseconds: 500), ()
      {
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
  void dispose() {
    super.dispose();
    advancedPlayer.release();
  }

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    advancedPlayer = widget.audioPlayer;
    background = widget.background;
//    setState(() {
//
//      advancedPlayer.release();
//      _timer = Timer(Duration(seconds: 1), () {
//        playSound(widget.level, widget.chapter.toString(),
//            widget.stage.toString(), widget.question_num.toString());
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    speedBloc.answerType = 2;
    setState(() {
      background.setVolume(0.5);
      playSound(widget.level, widget.chapter.toString(),
          widget.stage.toString(), widget.question_num.toString());
    });
    return WillPopScope(
      onWillPop: () {
        advancedPlayer.release();
        Navigator.of(context).pop();
      },
      child: body(MediaQuery.of(context).size),
    );
  }

  Widget body(Size size) {
    final bool iphonex = MediaQuery.of(context).size.height >= 812.0;

    return Container(
      width: size.width,
      height: (iphonex) ? size.height - 97 : size.height - 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/gamebox/img/speed/speed_dia_2.png",
              width: size.width,
              height: size.height,
              fit: BoxFit.fill,
            ),
            Positioned(
              top: size.height / 2.85,
              width: size.width - 20,
              child: Container(
                padding: EdgeInsets.only(right: 10.0),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      "assets/gamebox/img/speed/dia_que2.png",
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      top: 30,
                      left: 55,
                      child: Container(
                        width: size.width - 100,
                        child: Center(
                          child: Text(
                            widget.question,
                            style: speedDiaQuestionStyle,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.height / 3.8,
              child: Container(
                width: size.width,
                child: Center(
                  child: Text(
                    widget.title,
                    style: speedDiaTitleText,
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height / 2,
              child: message(size),
            ),
            soundFinish
                ? Container(
              width: 0,
              height: 0,
            )
                : Positioned(
              top: size.height / 2,
              child: Container(
                width: size.width - 20,
                height: 50,
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget message(Size size) {
    return Container(
      width: size.width - 20,
      height: 50,
      padding: const EdgeInsets.only(left: 20, right: 10.0),
      child: Stack(
        children: <Widget>[
          Image.asset(
            diaQue,
            width: size.width - 20,
            height: 50,
            fit: BoxFit.fill,
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "___",
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                controller: controller,
                onChanged: (value) {
                  print("onChange");
                  speedBloc.answerA = value;
                },
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
