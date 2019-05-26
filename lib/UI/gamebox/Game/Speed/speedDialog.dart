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

class SpeedGameDialog extends StatefulWidget {
  String level;
  int chapter;
  int stage;

  SpeedGameDialog({Key key, this.level, this.chapter, this.stage})
      : super(key: key);

  @override
  SpeedGameDialogState createState() => SpeedGameDialogState();
}

class SpeedGameDialogState extends State<SpeedGameDialog> {

  @override
  void initState() {
    speedBloc.getLevel(widget.level);
    speedBloc.getChapter(widget.chapter);
    speedBloc.getStage(widget.stage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    speedBloc.getQuestionList2().then((value) {
      String jsonValue = value;
      List<QuestionList> qList = speedBloc.questListToList(jsonValue);
//      setState(() {
        Navigator.of(context).pop();
        Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) => SpeedGame(
              level: widget.level,
              chapter: widget.chapter,
              stage: widget.stage,
              qList: qList,
            )));
//      });
    });

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );

//    return Scaffold(
//        backgroundColor: Colors.black.withOpacity(0.5),
//        body: SafeArea(
//          child: Padding(
//            child: StreamBuilder(
//              stream: speedBloc.stage,
//              builder: (context, snapshot) {
//                print("questionList = " + snapshot.hasData.toString());
//                if (snapshot.hasData) {
////                  String jsonValue = snapshot.data;
////                  List<QuestionList> qList =
////                      speedBloc.questListToList(jsonValue);
////                  setState(() {
////                    Navigator.of(context).pop();
////                  });s
//
////                  Navigator.of(context).push(PageRouteBuilder(
////                      opaque: false,
////                      pageBuilder:
////                          (BuildContext context, _, __) =>
////                          SpeedGame(
////                            level: widget.level,
////                            chapter: widget.chapter,
////                            stage: widget.stage,
////                            qList: qList,
////                          )));
//
////                  if (widget.level == "B") {
////                    return GameList(
////                        item: SpeedBronze(qList: qList).getViews(),
////                        size: MediaQuery.of(context).size);
////                  }else if(widget.level == "S"){
////                    return GameList(
////                        item: SpeedSilver(qList: qList).getViews(),
////                        size: MediaQuery.of(context).size);
////                  }else if(widget.level == "G"){
////                    return GameList(
////                        item: SpeedGold(qList: qList).getViews(),
////                        size: MediaQuery.of(context).size);
////                  }else if(widget.level == "D"){
////                    return GameList(
////                        item: SpeedDiamond(qList: qList).getViews(),
////                        size: MediaQuery.of(context).size);
////                  }
//
//                }
//                return SizedBox(
//                  width: 100.0,
//                  height: 100.0,
//                );
//              },
//            ),
//            padding: const EdgeInsets.all(10),
//          ),
//        ));
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
  @override
  void initState() {
    viewidx = 0;
  }

  @override
  Widget build(BuildContext context) {
    maxLen = widget.item.length;
    return ListView.builder(
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
    );
  }

  Widget nextBtn(Size size) {
    return InkWell(
      onTap: () {
        speedBloc.getAnswer(speedBloc.question_num).then((value) {
          Map<String, dynamic> json = jsonDecode(value);

          if (json['data'] == 'Y') {
            print("정답");
          } else if (json['data'] == 'N') {
            print("오답");
          }
          speedBloc.answer = 0;
          speedBloc.question_num = 0;
          speedBloc.answerA = "";
          speedBloc.answerType = 0;

          if (viewidx == maxLen - 1) {
            print("끝");
          } else {
            setState(() {
              print(viewidx);
              viewidx++;
            });
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
}
