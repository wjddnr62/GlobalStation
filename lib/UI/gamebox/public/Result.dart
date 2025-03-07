import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lms_flutter/UI/gamebox/gameDialog.dart';
import 'package:lms_flutter/bloc/member_bloc.dart';
import 'package:lms_flutter/model/UserInfo.dart';

import '../../../theme.dart';

class Result extends StatefulWidget {
  String level;
  int chapter;
  int stage;
  int score;
  int scoreLength;
  double sizeWidth;
  VoidCallback resetGame;
  int memberLevel;
  String type;

  Result(
      {Key key,
      this.level,
      this.chapter,
      this.stage,
      this.score,
      this.scoreLength,
      this.sizeWidth,
      this.resetGame,
      this.memberLevel,
      this.type})
      : super(key: key);

  @override
  ResultView createState() => ResultView();
}

class ResultView extends State<Result> {
  String level_full;
  String resultImgUrl;

  int memberLevel;
  int idx;

  bool NotNextGame = false;
  bool RowLevel = false;

  String lev;
  int cap;

  int coin = 0;

  bool coinInsert = false;
  String level;
  String type;
  int chapter;

  @override
  void initState() {
    memberLevel = widget.memberLevel;
    level = widget.level;
    type = widget.type;
    chapter = widget.chapter;

    print("resultMember : " + memberLevel.toString() + ", " + widget.level);

    if (widget.level == "P") {
      if (widget.chapter == 1) {
        idx = 0;
      } else if (widget.chapter == 2) {
        idx = 1;
      } else if (widget.chapter == 3) {
        idx = 2;
      }
    } else if (widget.level == "B") {
      if (widget.chapter == 1) {
        idx = 3;
      } else if (widget.chapter == 2) {
        idx = 4;
      } else if (widget.chapter == 3) {
        idx = 5;
      }
    } else if (widget.level == "S") {
      if (widget.chapter == 1) {
        idx = 6;
      } else if (widget.chapter == 2) {
        idx = 7;
      } else if (widget.chapter == 3) {
        idx = 8;
      }
    } else if (widget.level == "G") {
      if (widget.chapter == 1) {
        idx = 9;
      } else if (widget.chapter == 2) {
        idx = 10;
      } else if (widget.chapter == 3) {
        idx = 11;
      }
    } else if (widget.level == "D") {
      if (widget.chapter == 1) {
        idx = 12;
      } else if (widget.chapter == 2) {
        idx = 13;
      } else if (widget.chapter == 3) {
        idx = 14;
      }
    }

    if (memberLevel != idx) {
      coinInsert = true;
//      setState(() {});
    }

    if (idx != null) {
      idx += 1;
      print("idx : " + idx.toString());
      if (idx == 15) {
        NotNextGame = true;
//        setState(() {});
      }
      if (idx <= memberLevel) {
        if (idx <= 2) {
          lev = "P";
          cap = idx + 1;
        } else if (idx <= 5) {
          lev = "B";
          cap = idx - 2;
        } else if (idx <= 8) {
          lev = "S";
          cap = idx - 5;
        } else if (idx <= 11) {
          lev = "G";
          cap = idx - 8;
        } else if (idx <= 14) {
          lev = "D";
          cap = idx - 11;
        }
      } else {
        RowLevel = true;
//        setState(() {});
      }
    } else {
      print("idx null!!!!");
    }
  }

  nextGame() {
    if (!RowLevel) {
      print("resultData : " +
          idx.toString() +
          ", " +
          lev.toString() +
          ", " +
          cap.toString());
      Navigator.of(context).pop();
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) => GameDialog(
                idx: idx,
                lev: lev,
                cap: cap,
              )));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: new Text(
                  "Game Box는 현재 학생의 레벨까지만 이용이 가능합니다. 더 높은 레벨을 위해 열심히 노력하세요!"),
              actions: <Widget>[
                FlatButton(
                  child: Text("확인"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  level_set() {
    if (widget.level == "P") {
      level_full = "Phonics";
    } else if (widget.level == "B") {
      level_full = "Bronze";
    } else if (widget.level == "S") {
      level_full = "Silver";
    } else if (widget.level == "G") {
      level_full = "Gold";
    } else if (widget.level == "D") {
      level_full = "Diamond";
    }
  }

  resultImgSet() {
    double parent = widget.score / widget.scoreLength * 100;
    if (parent < 25) {
      resultImgUrl = "assets/gamebox/img/effect/1.png";
      if (!coinInsert){
        coin = 0;
      }
    } else if (parent > 25 && parent < 50) {
      resultImgUrl = "assets/gamebox/img/effect/2.png";
      if (!coinInsert){
        coin = 1;
      }
    } else if (parent > 50 && parent < 75) {
      resultImgUrl = "assets/gamebox/img/effect/3.png";
      if (!coinInsert){
        coin = 2;
      }
    } else if (parent > 75 && parent < 100) {
      resultImgUrl = "assets/gamebox/img/effect/4.png";
      if (!coinInsert){
        coin = 3;
      }
    } else if (parent >= 100) {
      resultImgUrl = "assets/gamebox/img/effect/5.png";
      if (!coinInsert){
        coin = 5;
      }
    }
  }

  updateCoin() {
    String id = UserInfo().child_user_id;
    print("id = ${id}, coin = ${coin}");
    mbloc.addCoin(id, coin, type, chapter, level).then((value) {
      print("Coin : " + value);
      if (json.decode(value)['result'] == 1) {
        UserInfo().member_coin = json.decode(value)['data']['coin'];
      } else if (json.decode(value)['result'] == 0) {
        setState(() {
          coin = 0;
        });
      }
    });
    coinInsert = true;
  }

  Widget result() {
    level_set();
    resultImgSet();
    if (!coinInsert) {
      updateCoin();
    }
    return Align(
      alignment: Alignment.topCenter,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                level_full + " ${widget.chapter}",
                style: resultTextStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Stage ",
                    style: TextStyle(
                        color: black,
                        fontSize: defaultFontSize + 8,
                        fontFamily: "Jua"),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.stage.toString(),
                        style: TextStyle(
                            color: resultStageColor,
                            fontSize: defaultFontSize + 8,
                            fontFamily: "Jua"),
                      )
                    ]),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                resultImgUrl,
                width: 300,
                height: 300,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "${widget.score.toString()}",
                      style: TextStyle(
                          fontSize: defaultFontSize,
                          fontFamily: 'Jua',
                          color: resultStageColor),
                      children: <TextSpan>[
                        TextSpan(
                            text: " / ${widget.scoreLength.toString()}",
                            style: TextStyle(
                                fontSize: defaultFontSize,
                                fontFamily: 'Jua',
                                color: black))
                      ])),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "획득 코인 ",
                      style: TextStyle(
                          fontSize: defaultFontSize,
                          fontFamily: 'Jua',
                          color: black),
                      children: <TextSpan>[
                        TextSpan(
                            text: "${coin}",
                            style: TextStyle(
                                fontSize: defaultFontSize,
                                fontFamily: 'Jua',
                                color: resultStageColor)),
                        TextSpan(
                          text: "개",
                          style: TextStyle(
                              fontSize: defaultFontSize,
                              fontFamily: 'Jua',
                              color: black),
                        )
                      ])),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    NotNextGame
                        ? Text("")
                        : GestureDetector(
                            onTap: () {
                              widget.resetGame();
                            },
                            child: Image.asset(
                              "assets/gamebox/img/effect/back_btn.png",
                              width: 100,
                              height: 50,
                            ),
                          ),
                    GestureDetector(
                      onTap: () {
                        nextGame();
                      },
                      child: Image.asset(
                        "assets/gamebox/img/effect/next_btn.png",
                        width: 100,
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget body() {
    return Container(
      width: widget.sizeWidth,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.topCenter,
            child: Container(
              width: widget.sizeWidth,
              child: result(),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return body();
  }
}
