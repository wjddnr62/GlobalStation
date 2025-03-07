import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_flutter/UI/gamebox/public/Result.dart';
import 'package:lms_flutter/UI/gamebox/public/Timer.dart';
import 'package:lms_flutter/UI/gamebox/public/questionStatus.dart';
import 'package:lms_flutter/bloc/quiz_game_bloc.dart';
import 'package:lms_flutter/model/Quiz/questionList.dart';
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

class QuizGameDialog extends StatefulWidget {
  String level;
  int chapter;
  int stage;
  VoidCallback callback, callback2;

  QuizGameDialog({Key key, this.level, this.chapter, this.stage, this.callback, this.callback2})
      : super(key: key);

  @override
  QuizGameDialogState createState() => QuizGameDialogState();
}

class QuizGameDialogState extends State<QuizGameDialog> {
  UserInfo userInfo = UserInfo();
  int review = 0;

  @override
  Widget build(BuildContext context) {
    memberLevel = userInfo.member_level;
    quizBloc.getLevel(widget.level);
    quizBloc.getChapter(widget.chapter);
    quizBloc.getStage(widget.stage);
    return WillPopScope(
      onWillPop: () {
        SchedulerBinding.instance
            .addPostFrameCallback((_) => widget.callback2());
        Navigator.of(context).pop();
      },
      child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.5),
          body: SafeArea(
            child: Padding(
              child: StreamBuilder(
                stream: quizBloc.getQuestionList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String jsonValue = snapshot.data;
                    List<QuestionList> qList =
                    quizBloc.questListToList(jsonValue);
                    if (widget.level == "P") {
                      return GameList(
                          item: QuizPhonics(qList: qList).getViews(),
                          size: MediaQuery.of(context).size,
                          level: widget.level,
                          chapter: widget.chapter,
                          stage: widget.stage,
                          restartView: restartView,
                          callback: widget.callback,
                          callback2: widget.callback2
                      );
                    } else if (widget.level == "B") {
                      return GameList(
                          item: QuizBronze(qList: qList).getViews(),
                          size: MediaQuery.of(context).size,
                          level: widget.level,
                          chapter: widget.chapter,
                          stage: widget.stage,
                          restartView: restartView,
                          callback: widget.callback,
                          callback2: widget.callback2);
                    } else if (widget.level == "S") {
                      return GameList(
                          item: QuizSilver(qList: qList).getViews(),
                          size: MediaQuery.of(context).size,
                          level: widget.level,
                          chapter: widget.chapter,
                          stage: widget.stage,
                          restartView: restartView,
                          callback: widget.callback,
                          callback2: widget.callback2);
                    } else if (widget.level == "G") {
                      return GameList(
                          item: QuizGold(qList: qList).getViews(),
                          size: MediaQuery.of(context).size,
                          level: widget.level,
                          chapter: widget.chapter,
                          stage: widget.stage,
                          restartView: restartView,
                          callback: widget.callback,
                          callback2: widget.callback2);
                    } else if (widget.level == "D") {
                      return GameList(
                          item: QuizDiamond(qList: qList).getViews(),
                          size: MediaQuery.of(context).size,
                          level: widget.level,
                          chapter: widget.chapter,
                          stage: widget.stage,
                          restartView: restartView,
                          callback: widget.callback,
                          callback2: widget.callback2);
                    }
                  }

                  return SizedBox(
                    width: 100.0,
                    height: 100.0,
                  );
                },
              ),
              padding: const EdgeInsets.all(10),
            ),
          )),
    );
  }

  restartView() {
    setState(() {
      review++;
    });
  }
}

class GameList extends StatefulWidget {
  final List<Widget> item;
  final Size size;
  String level;
  int chapter;
  int stage;
  VoidCallback restartView, callback, callback2;

  GameList(
      {Key key,
      this.item,
      this.size,
      this.level,
      this.chapter,
      this.stage,
      this.restartView,
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

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) => widget.callback());
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
    quizBloc.getAnswer(quizBloc.question_num).then((value) {
      Map<String, dynamic> json = jsonDecode(value);

      setState(() {
        answer = json['data'];
        quizBloc.answer = 0;
        quizBloc.question_num = 0;
        if (answer == 'N') answer = 'T';
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
    return mainGame();
  }

  Widget mainGame() {
    print("mainGameRebuild");
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Stack(
            children: <Widget>[
              widget.item[viewidx],
              Positioned(
                bottom: 20,
                child: nextBtn(widget.size),
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
              Navigator.of(context).pop();
            },
          ),
        ),
        checkAnswer(),
        (resultView)
            ? Positioned.fill(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.asset(
                          "assets/gamebox/img/effect/result_background.png"),
                    ),
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
                        type: "QUIZ",
                      ),
                    ),
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
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Positioned(
                top: 0,
                child: SizedBox(
                  width: 0,
                  height: 0,
                ),
              ),
      ],
    );
  }

  void restart() {
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

  Widget nextBtn(Size size) {
    return InkWell(
      onTap: () {
        print(quizBloc.answer);
        quizBloc.getAnswer(quizBloc.question_num).then((value) {
          Map<String, dynamic> json = jsonDecode(value);

//          setState(() {
            viewTimer = false;
            answer = json['data'];
            quizBloc.answer = 0;
            quizBloc.question_num = 0;
//          });
          setState(() {
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

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();

  Widget checkAnswer() {
    String img = "";
    if (answer == 'Y') {
      yay++;
      img = "assets/gamebox/img/quiz/yay.png";
      audioCache.play("gamebox/audio/sucess_sound.wav");
    } else if (answer == 'N') {
      img = "assets/gamebox/img/quiz/nope.png";
      audioCache.play("gamebox/audio/fail_sound.wav");
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
    _timer = new Timer(timeout, () {
      setState(() {
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
