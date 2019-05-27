import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_flutter/model/Speed/questionList.dart';
import 'package:lms_flutter/UI/gamebox/public/Timer.dart';
import 'package:lms_flutter/UI/gamebox/public/questionStatus.dart';
import 'package:lms_flutter/UI/gamebox/public/Result.dart';
import 'package:lms_flutter/model/UserInfo.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

import 'phonics.dart';
import 'bronze.dart';
import 'silver.dart';
import 'gold.dart';
import 'diamond.dart';

import 'speed.dart';

import 'package:lms_flutter/bloc/speed_game_bloc.dart';
import 'dart:convert';
import 'dart:async';

int viewidx;
int question_num = 0;
int maxLen;
int memberLevel;
int yay = 0;

class SpeedGame extends StatelessWidget {
  final String level;
  final int chapter;
  final int stage;
  final List<QuestionList> qList;

  SpeedGame({Key key, this.level, this.chapter, this.stage, this.qList})
      : super(key: key);

  UserInfo userInfo = UserInfo();
  int review = 0;

  @override
  Widget build(BuildContext context) {
    memberLevel = userInfo.member_level;
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: SafeArea(
          child: Padding(
            child: view(MediaQuery.of(context).size),
            padding: const EdgeInsets.all(10),
          ),
        ));
  }

  Widget view(Size size) {
    if (level == "P")
      return GameList(
        item: SpeedPhonics(qList: qList).getViews(),
        size: size,
        level: level,
        chapter: chapter,
        stage: stage,
      );
    if (level == "B")
      return GameList(
        item: SpeedBronze(qList: qList).getViews(),
        size: size,
        level: level,
        chapter: chapter,
        stage: stage,
      );
    if (level == "S")
      return GameList(
        item: SpeedSilver(qList: qList).getViews(),
        size: size,
        level: level,
        chapter: chapter,
        stage: stage,
      );
    if (level == "G")
      return GameList(
        item: SpeedGold(qList: qList).getViews(),
        size: size,
        level: level,
        chapter: chapter,
        stage: stage,
      );
    if (level == "D")
      return GameList(
        item: SpeedDiamond(qList: qList).getViews(),
        size: size,
        level: level,
        chapter: chapter,
        stage: stage,
      );
  }
}

class GameList extends StatefulWidget {
  final List<Widget> item;
  final Size size;
  String level;
  int chapter;
  int stage;

  GameList({
    Key key,
    this.item,
    this.size,
    this.level,
    this.chapter,
    this.stage,
  }) : super(key: key);

  @override
  GameListState createState() => GameListState();
}

class GameListState extends State<GameList> {
  String answer;
  bool viewTimer = true;
  bool resultView = false;
  bool restartGame = false;

  @override
  void initState() {
    viewidx = 0;
    answer = "";
    viewTimer = true;
    resultView = false;
    restartGame = false;
    yay = 0;
  }

  void finishTimer() {
    setState(() {
      viewTimer = false;
    });
    speedBloc.getAnswer(speedBloc.question_num).then((value) {
      Map<String, dynamic> json = jsonDecode(value);

      setState(() {
        answer = json['data'];
        speedBloc.answer = 0;
        speedBloc.question_num = 0;
        speedBloc.answerA = "";
        speedBloc.answerType = 0;
        if(answer == 'N') answer = 'T';
      });

      if (viewidx == maxLen - 1) {
        print("끝");
        setState(() {
          resultView = true;
        });
      } else {
        handleTimeout();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    maxLen = widget.item.length;
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, idx) {
              return Stack(
                children: <Widget>[
                  widget.item[viewidx],
                  Positioned(
                    bottom: 10,
                    child: nextBtn(widget.size),
                  ),
                  (viewTimer)
                      ? Positioned(
                    top: MediaQuery.of(context).size.width / 15,
                    child: TimerBar(
                      width: MediaQuery.of(context).size.width,
                      finishTimer: () => finishTimer(),
                    ),
                  )
                      : SizedBox(
                    width: 0,
                    height: 0,
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.width / 5,
                    child: QuestionStatus(
                      question_all_length: maxLen,
                      question_count: viewidx,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
              );
            },
            itemCount: widget.item.length,
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            child: Image.asset(
              "assets/gamebox/img/close_button.png",
              fit: BoxFit.contain,
              width: 25,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        checkAnswer(),

        (resultView)
            ? Positioned.fill(
          child: Stack(
            children: <Widget>[
              Image.asset(
                  "assets/gamebox/img/effect/result_background.png"),
              Center(
                child: Result(
                  level: widget.level,
                  chapter: widget.chapter,
                  stage: widget.stage,
                  score: yay,
                  scoreLength: maxLen,
                  sizeWidth: double.infinity,
                  resetGame: () => restart(),
                  memberLevel: memberLevel,
                ),
              )
            ],
          ),
        ): Positioned(
          top: 0,
          child: SizedBox(
            width: 0,
            height: 0,
          ),
        ),
      ],
    );
  }

  Widget nextBtn(Size size) {
    return InkWell(
      onTap: () {
        speedBloc.getAnswer(speedBloc.question_num).then((value) {
          Map<String, dynamic> json = jsonDecode(value);

          setState(() {
            viewTimer = false;
            answer = json['data'];
            speedBloc.answer = 0;
            speedBloc.question_num = 0;
            speedBloc.answerA = "";
            speedBloc.answerType = 0;
            ;
          });

          if (viewidx == maxLen - 1) {
            print("끝");
            setState(() {
              resultView = true;
            });
          } else {
            handleTimeout();
          }
        });
      },
      child: Container(
        width: size.width - 20,
        height: 40,
        child: Center(
          child: Image.asset(
            "assets/gamebox/img/next_btn.png",
            width: 80,
            height: 40,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
  void restart(){
    setState(() {
      print("restart");
      viewidx = 0;
      answer = "";
      viewTimer = true;
      resultView = false;
      restartGame = false;
      yay = 0;
    });
  }

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();

  Widget checkAnswer() {
    String img = "";
    if (answer == 'Y'){
      img = "assets/gamebox/img/quiz/yay.png";
      yay++;
      audioCache.play("gamebox/audio/sucess_sound.mp3");
    } else if (answer == 'N') {
      audioCache.play("gamebox/audio/fail_sound.mp3");
      img = "assets/gamebox/img/quiz/nope.png";
    } else if(answer == 'T') {
      img = "assets/gamebox/img/timeout.png";
      audioCache.play("gamebox/audio/fail_sound.mp3");
    }

    if (answer == "") {
      answer = "";
      return Positioned(
        top: 0,
        child: SizedBox(
          width: 0.0,
          height: 0.0,
        ),
      );
    }
    answer = "";
    return Positioned.fill(
      child: Container(
        child: Image.asset(img),
      ),
    );
  }

  final timeout = const Duration(seconds: 2);
  Timer _timer;

  void handleTimeout() {
    _timer = new Timer(timeout, () {
      setState(() {
        print("speedTimeout");
        answer = "";
        viewTimer = true;
        viewidx++;
      });
    });
  }

  @override
  void dispose() {
    if (_timer != null) _timer.cancel();

    super.dispose();
  }
}
