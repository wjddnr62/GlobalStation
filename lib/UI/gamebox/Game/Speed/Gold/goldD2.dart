import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/bloc/speed_game_bloc.dart';
import 'package:lms_flutter/theme.dart';

String answer = "";

class GoldD2 extends StatefulWidget {
  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;
  final String question;
  final AudioPlayer audioPlayer, background;

  GoldD2(
      {Key key,
      this.level,
      this.chapter,
      this.stage,
      this.question_num,
      this.title,
      this.question,
      this.audioPlayer, this.background})
      : super(key: key);

  @override
  Gold createState() => Gold();
}

class Gold extends State<GoldD2> {
//  String title = "Listen and choose the correct answer.";
//  String question = "We'll bring some ___ to the party.";

  final String goldQue = "assets/gamebox/img/speed/gold_ans.png";

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer, background;
  Timer _timer;
  String soundUrl;
  bool iphonex = false;

  playSound(String level, String chapter,String stage, String question_num) async {
    setState(() {
      advancedPlayer.release();
//      _timer = Timer(Duration(seconds: 1), ()
//      {
        if (soundUrl != "http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}") {
          advancedPlayer.setUrl(
              "http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}");
          advancedPlayer.resume();
          soundUrl = "http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}";
        }
//      });
    });

    advancedPlayer.onPlayerStateChanged.listen((state) {
      if (state == AudioPlayerState.COMPLETED) {
        background.setVolume(1.0);
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
    speedBloc.answerA = "";
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
    iphonex = MediaQuery.of(context).size.height >= 812.0;

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
              "assets/gamebox/img/speed/speed_gold_3.png",
              width: size.width,
              height: size.height,
              fit: BoxFit.fill,
            ),
            Positioned(
              top: size.height / 3.3,
              width: size.width - 20,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      "assets/gamebox/img/speed/gold_que2.png",
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      top: 32,
                      left: 55,
                      child: Container(
                        width: size.width - 100,
                        child: Center(
                          child: Text(
                            widget.question,
                            style: speedGoldQuestionStyle,
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
                    style: speedGoldTitleText,
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height / 2.07,
              child: wood(size),
            ),
          ],
        ),
      ),
    );
  }

  Widget wood(Size size) {
    return Container(
      width: size.width - 20,
      height:  (iphonex) ? 70 :60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: <Widget>[
          Image.asset(
            goldQue,
            width: size.width - 20,
            height: (iphonex) ? 70 :60,
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
                onChanged: (value) {
                  speedBloc.answerA = value;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
