import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/bloc/speed_game_bloc.dart';
import 'package:lms_flutter/theme.dart';

String answer = "";

class GoldE extends StatefulWidget {
  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;
  final String question;
  final AudioPlayer audioPlayer, background;
  final TextEditingController controller;

  GoldE(
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
  Gold createState() => Gold();
}

class Gold extends State<GoldE> {
//  String title = "Listen and choose the correct answer.";

  final String silverWood = "assets/gamebox/img/speed/sliver_ans.png";

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
              "assets/gamebox/img/speed/speed_gold_4.png",
              width: size.width,
              height: size.height,
              fit: BoxFit.fill,
            ),
            Positioned(
              top: size.height / 3.5,
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
              top: size.height / 2,
              child: answer(size),
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
                height: 55,
                color: Colors.transparent,
              ),
            )
          ],
        ),
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
