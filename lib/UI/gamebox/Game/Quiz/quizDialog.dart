import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_flutter/UI/gamebox/public/progressBar.dart';
import 'package:lms_flutter/bloc/quiz_game_bloc.dart';
import 'package:lms_flutter/model/Quiz/questionList.dart';

import 'phonics.dart';
import 'bronze.dart';
import 'silver.dart';
import 'gold.dart';
import 'diamond.dart';

import 'dart:convert';

int viewidx;
int question_num = 0;
int maxLen;

class QuizGameDialog extends StatefulWidget {
  String level;
  int chapter;
  int stage;

  QuizGameDialog({Key key, this.level, this.chapter, this.stage})
      : super(key: key);

  @override
  QuizGameDialogState createState() => QuizGameDialogState();
}

class QuizGameDialogState extends State<QuizGameDialog> {
  @override
  Widget build(BuildContext context) {
    print(widget.level);
    quizBloc.getLevel(widget.level);
    quizBloc.getChapter(widget.chapter);
    quizBloc.getStage(widget.stage);
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: SafeArea(
          child: Padding(
            child: StreamBuilder(
              stream: quizBloc.getQuestionList(),
              builder: (context, snapshot) {
                print("questionList = " + snapshot.hasData.toString());
                if (snapshot.hasData) {
                  String jsonValue = snapshot.data;
                  List<QuestionList> qList =
                      quizBloc.questListToList(jsonValue);
                  if (widget.level == "P") {
                    return GameList(
                        item: QuizPhonics(qList: qList).getViews(),
                        size: MediaQuery.of(context).size);
                  } else if (widget.level == "B") {
                    return GameList(
                        item: QuizBronze(qList: qList).getViews(),
                        size: MediaQuery.of(context).size);
                  } else if (widget.level == "S") {
                    return GameList(
                        item: QuizSilver(qList: qList).getViews(),
                        size: MediaQuery.of(context).size);
                  } else if (widget.level == "G") {
                    return GameList(
                        item: QuizGold(qList: qList).getViews(),
                        size: MediaQuery.of(context).size);
                  } else if (widget.level == "D") {
                    return GameList(
                        item: QuizDiamond(qList: qList).getViews(),
                        size: MediaQuery.of(context).size);
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
        ));
  }
}

class GameList extends StatefulWidget {
  final List<Widget> item;
  final Size size;

  GameList({Key key, this.item, this.size}) : super(key: key);

  @override
  GameListState createState() => GameListState();
}

class GameListState extends State<GameList> {
  String answer;

  @override
  void initState() {
    viewidx = 0;
    answer = "";
  }

  @override
  Widget build(BuildContext context) {
    maxLen = widget.item.length;
    print(maxLen);
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
                    bottom: 20,
                    child: nextBtn(widget.size),
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
      ],
    );
  }

  Widget nextBtn(Size size) {
    return InkWell(
      onTap: () {
        quizBloc.getAnswer(quizBloc.question_num).then((value) {
          Map<String, dynamic> json = jsonDecode(value);

//          if (json['data'] == 'Y') {
//            print("정답");
//          } else if (json['data'] == 'N') {
//            print("오답");
//          }
          setState(() {
            answer = json['data'];
            quizBloc.answer = 0;
            quizBloc.question_num = 0;
          });

          if (viewidx == maxLen - 1) {
            print("끝");
            Navigator.of(context).pop();
          } else {
            handleTimeout();
//            setState(() {
//              print(viewidx);
//              viewidx++;
//            });
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

  Widget checkAnswer() {
    String img = "";
    if (answer == 'Y')
      img = "assets/gamebox/img/quiz/yay.png";
    else if (answer == 'N') img = "assets/gamebox/img/quiz/nope.png";

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
        answer = "";
        viewidx++;
      });
    });
  }

  @override
  void dispose() {
    if(_timer != null)
      _timer.cancel();

    super.dispose();
  }
}
