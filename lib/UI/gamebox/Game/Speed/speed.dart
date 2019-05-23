import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_flutter/model/Speed/questionList.dart';

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

class SpeedGame extends StatelessWidget {
  final String level;
  final int chapter;
  final int stage;
  final List<QuestionList> qList;

  SpeedGame({Key key, this.level, this.chapter, this.stage, this.qList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: SafeArea(
          child: Padding(
//            child: StreamBuilder(
//              stream: _loadQuest,
//              builder: (context, snapshot) {
//                print("questionList = " + snapshot.hasData.toString());
//                if (snapshot.hasData) {
//                  String jsonValue = snapshot.data;
//                  List<QuestionList> qList =
//                  speedBloc.questListToList(jsonValue);
//                  if (widget.level == "B") {
//                    return GameList(
//                        item: SpeedBronze(qList: qList).getViews(),
//                        size: MediaQuery.of(context).size);
//                  }else if(widget.level == "S"){
//                    return GameList(
//                        item: SpeedSilver(qList: qList).getViews(),
//                        size: MediaQuery.of(context).size);
//                  }else if(widget.level == "G"){
//                    return GameList(
//                        item: SpeedGold(qList: qList).getViews(),
//                        size: MediaQuery.of(context).size);
//                  }else if(widget.level == "D"){
//                    return GameList(
//                        item: SpeedDiamond(qList: qList).getViews(),
//                        size: MediaQuery.of(context).size);
//                  }
//
//                }
//                return SizedBox(
//                  width: 100.0,
//                  height: 100.0,
//                );
//              },
//            ),
            child: view(MediaQuery.of(context).size),
            padding: const EdgeInsets.all(10),
          ),
        ));
  }

  Widget view(Size size) {
    if( level == "P")
      return GameList(
        item: SpeedPhonics(qList: qList).getViews(),
        size: size,
      );
    if (level == "B")
      return GameList(
        item: SpeedBronze(qList: qList).getViews(),
        size: size,
      );
    if (level == "S")
      return GameList(
        item: SpeedSilver(qList: qList).getViews(),
        size: size,
      );
    if (level == "G")
      return GameList(
        item: SpeedGold(qList: qList).getViews(),
        size: size,
      );
    if (level == "D")
      return GameList(
        item: SpeedDiamond(qList: qList).getViews(),
        size: size,
      );
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
        speedBloc.getAnswer(speedBloc.question_num).then((value) {
          Map<String, dynamic> json = jsonDecode(value);
//          if (json['data'] == 'Y') {
//            print("정답");
//          } else if (json['data'] == 'N') {
//            print("오답");
//          }
//          speedBloc.answer = 0;
//          speedBloc.question_num = 0;
//          speedBloc.answerA = "";
//          speedBloc.answerType = 0;

          setState(() {
            answer = json['data'];
            speedBloc.answer = 0;
            speedBloc.question_num = 0;
            speedBloc.answerA = "";
            speedBloc.answerType = 0;;
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
