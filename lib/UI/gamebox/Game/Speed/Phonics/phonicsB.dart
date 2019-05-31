import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/bloc/speed_game_bloc.dart';
import 'package:lms_flutter/model/Speed/answerList.dart';
import 'package:lms_flutter/theme.dart';

class PhonicsB extends StatefulWidget {
  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;
  final AudioPlayer audioPlayer, background;

  PhonicsB(
      {Key key,
      this.level,
      this.chapter,
      this.stage,
      this.question_num,
      this.title,
      this.audioPlayer,
      this.background})
      : super(key: key);

  @override
  Phonics createState() => Phonics();
}

class Phonics extends State<PhonicsB> {
//  String title = "Listen and choose the correct word.";

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer, background;
  Timer _timer;
  String soundUrl;

  playSound(
      String level, String chapter, String stage, String question_num) async {
    print("phonicsB_play");

    setState(() {
      advancedPlayer.release();
      _timer = Timer(Duration(seconds: 1), () {
        if (soundUrl !=
            "http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}") {
          advancedPlayer.setUrl(
              "http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}");
          advancedPlayer.resume();
          soundUrl =
              "http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}";
        }
      });
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
//    soundUrl = "http://ga.oig.kr/laon_api/api/asset/sound/${widget.level}/${widget.chapter}/S${widget.stage}/${widget.question_num}";
//    setState(() {
//      advancedPlayer.release();
//        playSound(widget.level, widget.chapter.toString(),
//            widget.stage.toString(), widget.question_num.toString());
//    });
  }

  @override
  Widget build(BuildContext context) {
    speedBloc.answerType = 1;
    speedBloc.getLevel(widget.level);
    speedBloc.getChapter(widget.chapter);
    speedBloc.getStage(widget.stage);
    speedBloc.question_num = widget.question_num;
    clickAnswer = speedBloc.answer;
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
      child: StreamBuilder(
          stream: speedBloc.getAnswerList(widget.question_num),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String jsonValue = snapshot.data;
              List<AnswerList> answerList =
                  speedBloc.answerListToList(jsonValue);
              return Stack(
                children: <Widget>[
                  Container(
                    width: size.width,
                    height: size.height,
                    child: Image.asset(
                      "assets/gamebox/img/speed/speed_phonics_bg.png",
                      fit: BoxFit.fill,
                      width: size.width,
                      height: size.height,
                    ),
                  ),
                  Positioned(
                    top: size.height / 3.6,
                    child: Container(
                      width: size.width,
                      child: Center(
                        child: Text(
                          widget.title,
                          style: speedPhonicsTitleStyle,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height / 2.5,
                    right: 30,
                    child: questionText(answerList[0].contents, 1),
                  ),
                  Positioned(
                    top: size.height / 2.5,
                    left: 30,
                    child: questionText(answerList[1].contents, 2),
                  ),
                  Positioned(
                    top: size.height / 1.8,
                    right: 30,
                    child: questionText(answerList[2].contents, 3),
                  ),
                  Positioned(
                    top: size.height / 1.8,
                    left: 30,
                    child: questionText(answerList[3].contents, 4),
                  ),
                ],
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }

  int clickAnswer = 0;

  Widget questionText(String data, int idx) {
    return Container(
      width: 160,
      height: 280,
      child: InkWell(
        onTap: () {
          speedBloc.answer = idx;
          setState(() {
            clickAnswer = idx;
          });
        },
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/gamebox/img/speed/balloon.png",
              width: 160,
              height: (idx == clickAnswer) ? 280 : 250,
              fit: BoxFit.contain,
            ),
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: Container(
                width: 100,
                height: 100,
                child: Center(
                  child: Text(
                    data,
                    style: questionTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
