import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_flutter/UI/gamebox/public/Result.dart';
import 'package:lms_flutter/UI/gamebox/public/Timer.dart';
import 'package:lms_flutter/UI/gamebox/public/questionStatus.dart';
import 'package:lms_flutter/bloc/game_public_bloc.dart';
import 'package:lms_flutter/bloc/speed_game_bloc.dart';
import 'package:lms_flutter/model/Speed/questionList.dart';
import 'package:lms_flutter/model/UserInfo.dart';

import 'bronze.dart';
import 'diamond.dart';
import 'gold.dart';
import 'phonics.dart';
import 'silver.dart';

int viewidx;
int question_num = 0;
int maxLen;
int memberLevel;
int yay = 0;
AudioPlayer audioPlayer = AudioPlayer();

class SpeedGame extends StatelessWidget {
  final String level;
  final int chapter;
  final int stage;
  final List<QuestionList> qList;
  AudioPlayer background;
  TextEditingController controller;
  GamePublicBloc gamePublicBloc = GamePublicBloc();
  VoidCallback callback, callback2;

  SpeedGame(
      {Key key,
      this.level,
      this.chapter,
      this.stage,
      this.qList,
      this.background,
      this.controller,
      this.callback,
      this.callback2})
      : super(key: key);

  UserInfo userInfo = UserInfo();
  int review = 0;

  @override
  Widget build(BuildContext context) {
    memberLevel = userInfo.member_level;
    audioPlayer.release();
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
          item: SpeedPhonics(
                  qList: qList,
                  audioPlayer: audioPlayer,
                  background: background,
                  controller: controller)
              .getViews(),
          size: size,
          level: level,
          chapter: chapter,
          stage: stage,
          background: background,
          audioplayer: audioPlayer,
          callback: callback,
          callback2: callback2);
    if (level == "B")
      return GameList(
        item: SpeedBronze(
                qList: qList,
                audioPlayer: audioPlayer,
                background: background,
                controller: controller)
            .getViews(),
        size: size,
        level: level,
        chapter: chapter,
        stage: stage,
        background: background,
        audioplayer: audioPlayer,
          callback: callback,
          callback2: callback2
      );
    if (level == "S")
      return GameList(
        item: SpeedSilver(
                qList: qList,
                audioPlayer: audioPlayer,
                background: background,
                controller: controller)
            .getViews(),
        size: size,
        level: level,
        chapter: chapter,
        stage: stage,
        background: background,
        audioplayer: audioPlayer,
          callback: callback,
          callback2: callback2
      );
    if (level == "G")
      return GameList(
        item: SpeedGold(
                qList: qList,
                audioPlayer: audioPlayer,
                background: background,
                controller: controller)
            .getViews(),
        size: size,
        level: level,
        chapter: chapter,
        stage: stage,
        background: background,
        controller: controller,
        audioplayer: audioPlayer,
          callback: callback,
          callback2: callback2
      );
    if (level == "D")
      return GameList(
        item: SpeedDiamond(
                qList: qList,
                audioPlayer: audioPlayer,
                background: background,
                controller: controller)
            .getViews(),
        size: size,
        level: level,
        chapter: chapter,
        stage: stage,
        background: background,
        controller: controller,
        audioplayer: audioPlayer,
          callback: callback,
          callback2: callback2
      );
  }
}

class GameList extends StatefulWidget {
  final List<Widget> item;
  final Size size;
  String level;
  int chapter;
  int stage;
  AudioPlayer background, audioplayer;
  TextEditingController controller;
  VoidCallback callback, callback2;

  GameList(
      {Key key,
      this.item,
      this.size,
      this.level,
      this.chapter,
      this.stage,
      this.background,
      this.controller,
      this.audioplayer,
      this.callback,
      this.callback2})
      : super(key: key);

  @override
  GameListState createState() => GameListState();
}

class GameListState extends State<GameList> {
  String answer;
  bool viewTimer = true;
  bool resultView = false;
  bool restartGame = false;
  bool soundFinish = false;
  bool nextStage = false;
  AudioPlayer background, audioplayer;
  TextEditingController controller;
  GamePublicBloc gamePublicBloc = GamePublicBloc();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) => widget.callback());
    controller = widget.controller;
    advancedPlayer.setReleaseMode(ReleaseMode.STOP);
    viewidx = 0;
    answer = "";
    viewTimer = true;
    resultView = false;
    restartGame = false;
    yay = 0;
    maxLen = widget.item.length;
    print("gameList init");
    background = widget.background;
    audioplayer = widget.audioplayer;
    nextStage = false;
    audioplayer.onPlayerStateChanged.listen((state) {
      if (state == AudioPlayerState.COMPLETED) {
        setState(() {
          print("speed soundFinish : " + soundFinish.toString());
          soundFinish = true;
        });
      }
    });
  }

  void finishTimer() {
    setState(() {
      viewTimer = false;
    });
    speedBloc.getAnswer(speedBloc.question_num).then((value) {
      Map<String, dynamic> json = jsonDecode(value);

      answer = json['data'];
      if (json['result'] == 0) answer = 'N';
      speedBloc.answer = 0;
      speedBloc.question_num = 0;
      speedBloc.answerA = "";
      speedBloc.answerType = 0;
      if (answer == 'N') answer = 'T';

      setState(() {});

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
    print("speed Build");
    maxLen = widget.item.length;
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Stack(
              children: <Widget>[
                nextStage
                    ? Container(
                        width: 0,
                        height: 0,
                      )
                    : widget.item[viewidx],
                Positioned(
                  bottom: 10,
                  child: soundFinish
                      ? nextBtn(widget.size)
                      : Container(
                          width: 80,
                          height: 40,
                          color: Colors.transparent,
                        ),
                ),
                (viewTimer)
                    ? Positioned(
                        top: MediaQuery.of(context).size.width / 15,
                        child: TimerBar(
                          width: MediaQuery.of(context).size.width,
                          finishTimer: () => finishTimer(),
                          level: widget.level,
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
                SchedulerBinding.instance
                    .addPostFrameCallback((_) => widget.callback2());
                audioPlayer.stop();
                Navigator.of(context).pop();
              },
            ),
          ),
          checkAnswer(),
          (resultView)
              ? Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: Image.asset(
                            "assets/gamebox/img/effect/result_background.png")),
                    Positioned.fill(
                        child: Center(
                      child: Result(
                        level: widget.level,
                        chapter: widget.chapter,
                        stage: widget.stage,
                        score: yay,
                        scoreLength: maxLen,
                        sizeWidth: double.infinity,
                        resetGame: () => restart(),
                        memberLevel: memberLevel,
                        type: "SPEED",
                      ),
                    )),
                    Positioned(
                      top: MediaQuery.of(context).size.width / 30,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: 20,
                        padding: EdgeInsets.only(right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              child: Image.asset(
                                  "assets/gamebox/img/close_button.png"),
                              onTap: () {
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) => widget.callback2());
                                audioPlayer.stop();
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Positioned(
                  top: 0,
                  child: SizedBox(
                    width: 0,
                    height: 0,
                  ),
                ),
        ],
      ),
      onWillPop: () {
        Navigator.of(context).pop();
        SchedulerBinding.instance
            .addPostFrameCallback((_) => widget.callback2());
      },
    );
  }

  Widget nextBtn(Size size) {
    return InkWell(
      onTap: () {
        speedBloc.getAnswer(speedBloc.question_num).then((value) {
          Map<String, dynamic> json = jsonDecode(value);
          viewTimer = false;

          answer = json['data'];
          if (json['result'] == 0) answer = 'N';
          speedBloc.answer = 0;
          speedBloc.question_num = 0;
          speedBloc.answerA = "";
          speedBloc.answerType = 0;
          if (controller != null) {
            controller.clear();
          }

          setState(() {
            soundFinish = false;
            audioPlayer.release();
            background.setVolume(1.0);
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

  void restart() {
    print("restart");
    viewidx = 0;
    answer = "";
    if (controller != null) {
      controller.clear();
    }
    viewTimer = true;
    resultView = false;
    restartGame = false;
    yay = 0;
    setState(() {});
  }

//  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  AudioCache audioCache;

  Widget checkAnswer() {
//    audioPlayer.release();
    background.setVolume(1.0);
    print("checkAnswer");
    setState(() {
//      soundFinish = false;
//      nextStage = true;
//      nextStage = false;
    });
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
    String img = "";
    if (answer == 'Y') {
      img = "assets/gamebox/img/quiz/yay.png";
      yay++;
      audioCache.play("gamebox/audio/sucess_sound.wav");
    } else if (answer == 'N') {
      audioCache.play("gamebox/audio/fail_sound.wav");
      img = "assets/gamebox/img/quiz/nope.png";
    } else if (answer == 'T') {
      img = "assets/gamebox/img/timeout.png";
      audioCache.play("gamebox/audio/fail_sound.wav");
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
    if (controller != null) {
      controller.clear();
    }
    return Positioned.fill(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Image.asset(img),
      ),
    );
  }

  final timeout = const Duration(seconds: 2);
  Timer _timer;

  void handleTimeout() {
//    audioPlayer.release();
    _timer = new Timer(timeout, () {
      print("speedTimeout");
      answer = "";
      if (controller != null) {
        controller.clear();
      }
      viewTimer = true;
      viewidx++;
      setState(() {
//        nextStage = true;
//        nextStage = false;
        soundFinish = false;
        audioPlayer.release();
        background.setVolume(1.0);
      });
    });
  }

  @override
  void dispose() {
    if (_timer != null) _timer.cancel();
    audioPlayer.release();
    background.setVolume(1.0);
    super.dispose();
  }
}
