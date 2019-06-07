import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';
import 'package:lms_flutter/model/Speed/answerList.dart';
import 'package:lms_flutter/bloc/speed_game_bloc.dart';

int answer = 0;

class BronzeB extends StatefulWidget {
  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;
  final AudioPlayer audioPlayer, background;

  BronzeB({Key key, this.level, this.chapter, this.stage, this.question_num,this.title, this.audioPlayer, this.background})
      : super(key: key);

  @override
  Bronze createState() => Bronze();
}

class Bronze extends State<BronzeB> {

  final String A_POSTIT = "assets/gamebox/img/speed/postitA.png";
  final String B_POSTIT = "assets/gamebox/img/speed/postitB.png";

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer, background;
  Timer _timer;
  String soundUrl;

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
          builder: (context, snapshot){
            if(snapshot.hasData){
              String jsonValue = snapshot.data;
              List<AnswerList> answerList = speedBloc.answerListToList(jsonValue);

              return Stack(
                children: <Widget>[
                  Image.asset(
                    "assets/gamebox/img/speed/speed_bronze_1.png",
                    width: size.width,
                    height: size.height,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    top: size.height / 3.4,
                    child: Container(
                      width: size.width,
                      child: Center(
                        child: Text(
                          widget.title,
                          style: speedBronzeTitleStyleB,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: size.height / 2.5,
                    child: postIt("A", answerList[0].contents,1),
                  ),
                  Positioned(
                    right: 20,
                    top: size.height / 2.5,
                    child: postIt("B", answerList[1].contents,2),
                  ),
                  Positioned(
                    left: 20,
                    top: size.height / 1.6,
                    child: postIt("B", answerList[2].contents,3),
                  ),
                  Positioned(
                    right: 20,
                    top: size.height / 1.6,
                    child: postIt("A", answerList[3].contents,4),
                  ),

//                Align(
//                  alignment: AlignmentDirectional.bottomCenter,
//                  child: nextBtn(size),
//                ),
                ],
              );
            }

            return CircularProgressIndicator();
          },
        )
    );
  }


  int clickAnswer = 0;

  Widget postIt(String type, String text,int idx) {
    return Container(
      width: 160,
      height: 160,
      child: InkWell(
        onTap:(){
          answer = idx;
          speedBloc.answer = answer;
        setState(() {
          clickAnswer = idx;
        });

        },
        child: Stack(
          children: <Widget>[
            Image.asset(
              (type == "A") ? A_POSTIT : B_POSTIT,
              width: (idx == clickAnswer)? 160 : 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            Center(child: Text(text, style: speedBronzeQuestionStyle,),)
          ],
        ),
      ),
    );
  }

  Widget nextBtn(Size size) {
    return InkWell(
      onTap: (){},
      child: Container(
        width: size.width,
        height: 40,
        child: Image.asset(
          "assets/gamebox/img/next_btn.png",
          width: 100,
          height: 40,
        ),
      ),
    );
  }
}

