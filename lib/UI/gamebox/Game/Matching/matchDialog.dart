import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_flutter/UI/gamebox/Game/Matching/diamond.dart';
import 'package:lms_flutter/UI/gamebox/Game/Matching/gold.dart';
import 'package:lms_flutter/UI/gamebox/Game/Matching/phonics.dart';
import 'package:lms_flutter/UI/gamebox/Game/Matching/silver.dart';
import 'package:lms_flutter/bloc/match_game_bloc.dart';
import 'package:lms_flutter/model/Match/questionList.dart';

import 'bronze.dart';

int viewidx;
int question_num = 0;
int maxLen;

class MatchGameDialog extends StatefulWidget {
  String level;
  int chapter;
  int stage;
  VoidCallback callback, callback2;

  MatchGameDialog({Key key, this.level, this.chapter, this.stage, this.callback, this.callback2})
      : super(key: key);

  @override
  MatchGameDialogState createState() => MatchGameDialogState();
}

class MatchGameDialogState extends State<MatchGameDialog> {
  @override
  Widget build(BuildContext context) {
    matchBloc.getLevel(widget.level);
    matchBloc.getChapter(widget.chapter);
    matchBloc.getStage(widget.stage);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: SafeArea(
        child: Padding(
          child: StreamBuilder(
              stream: matchBloc.getQuestionList(),
              builder: (context, snapshot) {
                print("phonics_questionList = " + snapshot.hasData.toString());
                if (snapshot.hasData) {
                  String jsonValue = snapshot.data;
                  List<QuestionList> qList =
                      matchBloc.questListToList(jsonValue);
                  if (widget.level == "P") {
                    return GameList(
                      item: MatchPhonics(qList: qList, callback2: widget.callback2).getViews(),
                      size: MediaQuery.of(context).size,
                      callback: widget.callback,
                    );
                  } else if (widget.level == "B") {
                    return GameList(
                      item: MatchBronze(qList: qList, callback2: widget.callback2).getViews(),
                      size: MediaQuery.of(context).size,
                        callback: widget.callback,
                    );
                  } else if (widget.level == "S") {
                    return GameList(
                      item: MatchSilver(qList: qList, callback2: widget.callback2).getViews(),
                      size: MediaQuery.of(context).size,
                        callback: widget.callback,
                    );
                  } else if (widget.level == "G") {
                    return GameList(
                      item: MatchGold(qList: qList, callback2: widget.callback2).getViews(),
                      size: MediaQuery.of(context).size,
                        callback: widget.callback,
                    );
                  } else if (widget.level == "D") {
                    return GameList(
                      item: MatchDiamond(qList: qList, callback2: widget.callback2).getViews(),
                      size: MediaQuery.of(context).size,
                        callback: widget.callback,
                    );
                  }
                }
                return SizedBox(
                  width: 100.0,
                  height: 100.0,
                );
              }),
          padding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}

class GameList extends StatefulWidget {
  final List<Widget> item;
  final Size size;
  VoidCallback callback, callback2;

  GameList({Key key, this.item, this.size, this.callback, this.callback2}) : super(key: key);

  @override
  GameListState createState() => GameListState();
}

class GameListState extends State<GameList> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) => widget.callback());
    viewidx = 0;
  }

  @override
  Widget build(BuildContext context) {
    maxLen = widget.item.length;
    print(maxLen);
    return Stack(
      children: <Widget>[
        Positioned.fill(
            child: Stack(
          children: <Widget>[
            widget.item[viewidx],
          ],
        ))

//            Positioned(
//              bottom: 50,
//              child: nextBtn(widget.size),
//            )
      ],
    );
  }

  Widget nextBtn(Size size) {
    return InkWell(
      onTap: () {
        matchBloc.getAnswer(matchBloc.question_num).then((value) {
          Map<String, dynamic> json = jsonDecode(value);

          if (json['data'] == 'Y') {
            print("정답");
          } else if (json['data'] == 'N') {
            print("오답");
          }

          matchBloc.answer = 0;
          matchBloc.question_num = 0;

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
