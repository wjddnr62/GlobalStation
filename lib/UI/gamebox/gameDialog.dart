import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_flutter/UI/gamebox/Game/Quiz/quizDialog.dart';
import 'package:lms_flutter/UI/gamebox/Game/Speed/speedDialog.dart';
import 'package:lms_flutter/model/stage.dart';
import 'package:lms_flutter/theme.dart';
import 'package:lms_flutter/model/UserInfo.dart';

import 'package:lms_flutter/bloc/game_public_bloc.dart';

import 'Game/Matching/matchDialog.dart';
import 'Game/Speed/phonics.dart';
import 'Game/Speed/bronze.dart';
import 'Game/Speed/silver.dart';
import 'Game/Speed/gold.dart';
import 'Game/Speed/diamond.dart';

import 'Game/Speed/speed.dart';

import 'Game/Quiz/Phonics/phonics.dart';
import 'Game/Quiz/Bronze//bronze.dart';
import 'Game/Quiz/Silver/silver.dart';
import 'Game/Quiz/Gold/gold.dart';
import 'Game/Quiz/Diamond/diamond.dart';

import 'Game/Matching/Phonics/phonics.dart';

class GameDialog extends StatefulWidget {
  int idx;
  String lev;
  int cap;

  GameDialog({Key key, this.idx, this.lev, this.cap}) : super(key: key);

  @override
  GameDialogState createState() => GameDialogState();
}

class GameDialogState extends State<GameDialog> {
  String dialogType = "";
  String selectGame = "";

  bool startGame = false;
  List<String> list = UserInfo().levelList;

  @override
  void initState() {
    super.initState();
    dialogType = "K"; // K == GameKind | S == GameState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: dialogType == "K"
            ? SafeArea(
                child: Padding(
                  child: selectGameKind(),
                  padding: const EdgeInsets.all(10),
                ),
              )
            : SafeArea(
                child: Padding(
                  child: selectGameStage(),
                  padding: const EdgeInsets.all(10),
                ),
              ));
  }

  Widget selectGameKind() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: dialogBackground),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Image.asset(
                    "assets/gamebox/img/lobby_logo.png",
                    width: 120,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    child: Text("x"),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            list[widget.idx],
            style: levelTextStyle,
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          dialogType = "S";
                          selectGame = "S";
                        });
                      },
                      child: dialogView("SPEED GAME"),
                    ),
                  ),
                  defaultSpace(),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          dialogType = "S";
                          selectGame = "M";
                        });
                      },
                      child: dialogView("MATCHING GAME"),
                    ),
                  ),
                  defaultSpace(),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          dialogType = "S";
                          selectGame = "Q";
                        });
                      },
                      child: dialogView("QUIZ GAME"),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectGameStage() {
    gameBloc.changeLevel(widget.lev);
    gameBloc.changeChapter(widget.cap);

    gameBloc.getStageList(selectGame).then((value) {
      gameBloc.response = value;
      gameBloc.changeStage(true);
    });

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: dialogBackground),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Image.asset(
                    "assets/gamebox/img/lobby_logo.png",
                    width: 120,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    child: Text("x"),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: StreamBuilder(
                stream: gameBloc.stage,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Stage> stages = gameBloc.jsonToList(gameBloc.response);
                    return ListView.builder(
                      itemCount: stages.length,
                      itemBuilder: (context, idx) {
                        print("1");
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            child: InkWell(
                              onTap: () {
//                                setState(() {
//                                  startGame = true;
//                                });

                                if (selectGame == "S") {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder:
                                          (BuildContext context, _, __) =>
                                              SpeedGameDialog(
                                                level: widget.lev,
                                                chapter: widget.cap,
                                                stage: stages[idx].stage,
                                              )));
                                }else if (selectGame == "Q") {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder:
                                          (BuildContext context, _, __) =>
                                          QuizGameDialog(
                                            level: widget.lev,
                                            chapter: widget.cap,
                                            stage: stages[idx].stage,
                                          )));
                                }else if (selectGame == "M") {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (BuildContext context, _, __) => MatchGameDialog(
//                      level: widget.lev,
                                        level: widget.lev,
                                        chapter: widget.cap,
                                        stage: stages[idx].stage,
                                      )));
                                }
                              },
                              child: dialogView(
                                  "STAGE " + stages[idx].stage.toString()),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),

            ),
          ),
        ],
      ),
    );
  }
}

Widget dialogView(String text) {
  return Container(
    width: double.infinity,
    decoration: dialogContainerDeco,
    child: Center(
      child: Text(
        text,
        style: dialogTextStyle,
      ),
    ),
  );
}

Widget defaultSpace() {
  return SizedBox(
    height: 30.0,
  );
}
