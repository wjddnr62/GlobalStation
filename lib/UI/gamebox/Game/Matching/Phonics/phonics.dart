import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lms_flutter/UI/gamebox/public/Result.dart';
import 'package:lms_flutter/UI/gamebox/public/questionStatus.dart';
import 'package:lms_flutter/bloc/match_game_bloc.dart';
import 'package:lms_flutter/model/Match/answerList.dart';

class Phonics extends StatefulWidget {
  final String level;
  final int chapter;
  final int stage;
  final int question_num;


  Phonics({Key key, this.level, this.chapter, this.stage, this.question_num})
      : super(key: key);

  @override
  PhonicsM createState() => PhonicsM();
}

class PhonicsM extends State<Phonics> {
  String shell1Close = "assets/gamebox/img/match/shell_close.png";
  String shell1Open = "assets/gamebox/img/match/shell.png";

  String shell2Close = "assets/gamebox/img/match/shell2_close.png";
  String shell2Open = "assets/gamebox/img/match/shell2.png";

  String default_pic = "http://ga.oig.kr/laon_api/api/asset/";

  bool answer_check = false;
  bool next_question = false;
  bool answer_finish = false;

  String answer_one = "";
  String answer_two = "";
  int answer_count = 0;
  int answer_finish_count = 0;
  int answer_all_length = 0;

  String finish_img;

  int answer_one_list;
  int answer_one_no;
  int answer_one_type;
  String answer_one_param;

  int answer_two_list;
  int answer_two_no;
  int answer_two_type;
  String answer_two_param;

  List<AnswerList> answerList = new List();

  int next_problem = 0;

  List<shellData> firstShell = new List();
  List<shellData> secondShell = new List();
  List<shellData> firstShell_sub = new List();
  List<shellData> secondShell_sub = new List();

  List<shellParam> shell_param = new List();

  int dataSetCheck = 0;
  double opacity = 1;

  bool isOpen = true;



  void isOpenChange() {
    print("Open_Change : " + this.isOpen.toString());
    if (this.isOpen = true) {
      setState(() {
        dataSetCheck = 0;
        this.isOpen = false;
      });
    }
  }

  inVisible() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, isOpenChange);
  }

  nextQuestion() async {
    print("next_async");
    return Timer(Duration(seconds: 1), nextQ);
  }

  finishResult() async {
    return Timer(Duration(seconds: 1), resultView);
  }

  void resultView() {
    setState(() {
      next_question = false;
      answer_finish = true;
    });
  }

  void nextQ() {
    setState(() {
      next_question = false;
//      this.isOpen = true;
      answer_count = 0;
      next_problem = 1;
      dataSetCheck = 0;
//      inVisible();
    });
  }

  void answerReset() {
    setState(() {
      if (answer_one_list == 1) {
        firstShell.removeAt(answer_one_no);
        firstShell.insert(
            answer_one_no, shellData(answer_one_type, false, answer_one, 1));
      } else if (answer_one_list == 2) {
        secondShell.removeAt(answer_one_no);
        secondShell.insert(
            answer_one_no, shellData(answer_one_type, false, answer_one, 1));
      }
      if (answer_two_list == 1) {
        firstShell.removeAt(answer_two_no);
        firstShell.insert(
            answer_two_no, shellData(answer_two_type, false, answer_two, 1));
      } else if (answer_two_list == 2) {
        secondShell.removeAt(answer_two_no);
        secondShell.insert(
            answer_two_no, shellData(answer_two_type, false, answer_two, 1));
      }
      rowData(1);
      rowData(2);
      answer_one = "";
      answer_two = "";
      answer_check = false;
    });
  }

  void answerOk() {
    setState(() {
      if (answer_one_list == 1) {
        firstShell.removeAt(answer_one_no);
        firstShell.insert(
            answer_one_no, shellData(answer_one_type, true, answer_one, 0.0));
      } else if (answer_one_list == 2) {
        secondShell.removeAt(answer_one_no);
        secondShell.insert(
            answer_one_no, shellData(answer_one_type, true, answer_one, 0.0));
      }
      if (answer_two_list == 1) {
        firstShell.removeAt(answer_two_no);
        firstShell.insert(
            answer_two_no, shellData(answer_two_type, true, answer_two, 0.0));
      } else if (answer_two_list == 2) {
        secondShell.removeAt(answer_two_no);
        secondShell.insert(
            answer_two_no, shellData(answer_two_type, true, answer_two, 0.0));
      }
      rowData(1);
      rowData(2);
      answer_one = "";
      answer_two = "";
      answer_count += 1;
      print("count_up");
      print("all_length : " +
          answer_all_length.toString() +
          ", " +
          answer_finish_count.toString());
      if (answer_all_length != 5 && answer_count == 3) {
        answer_finish_count += 1;
        answer_all_length += 1;
        if (answer_all_length == 5) {
          next_question = true;
          resultView();
        } else {
          print("next_question");
          next_question = true;
          nextQuestion();
          rowData(1);
          rowData(2);
          inVisible();
        }
      }
      answer_check = false;
    });
  }

  answerCheck(int answerNo) async {
    print("an2");
    if (answerNo == 0) {
      return Timer(Duration(seconds: 1), answerReset);
    } else if (answerNo == 1) {
      return Timer(Duration(seconds: 1), answerOk);
    }
  }

  void resetGame() {
    print("P_M_reset");
  }

  void resultNextGame() {
    print("P_M_resultNextGame");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inVisible();
    print("invisible");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    matchBloc.getLevel(widget.level);
    matchBloc.getChapter(widget.chapter);
    matchBloc.getStage(widget.stage);
    matchBloc.question_num = widget.question_num;
    return body(MediaQuery.of(context).size);
  }

  Widget body(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: StreamBuilder(
        stream: matchBloc.getAnswerList(widget.question_num),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String jsonValue = snapshot.data;
            answerList = matchBloc.answerListToList(jsonValue);
            if (next_problem != 2) {
              if (dataSetCheck != 1) {
                firstShell.clear();
                for (int i = 0; i < 3; i++) {
                  if (answerList[i].en == null || answerList[i].en == "") {
                    firstShell
                        .add(shellData(1, this.isOpen, answerList[i].img, 1));
                  } else {
                    firstShell
                        .add(shellData(2, this.isOpen, answerList[i].en, 1));
                  }
                }
                secondShell.clear();
                for (int i = 3; i < 6; i++) {
                  if (answerList[i].en == null || answerList[i].en == "") {
                    secondShell
                        .add(shellData(1, this.isOpen, answerList[i].img, 1));
                  } else {
                    secondShell
                        .add(shellData(2, this.isOpen, answerList[i].en, 1));
                  }
                }
                if (next_problem == 1) {
                  firstShell_sub.clear();
                  for (int i = 0; i < firstShell.length; i++) {
                    firstShell_sub.add(shellData(firstShell[i].type,
                        this.isOpen, firstShell[i].param, 1));
                  }
                  secondShell_sub.clear();
                  for (int i = 0; i < secondShell.length; i++) {
                    secondShell_sub.add(shellData(secondShell[i].type,
                        this.isOpen, secondShell[i].param, 1));
                  }
                  next_problem = 2;
                }
              }
            } else if (next_problem == 2 && dataSetCheck != 1) {
              firstShell.clear();
              for (int i = 0; i < firstShell_sub.length; i++) {
                firstShell.add(shellData(firstShell_sub[i].type, this.isOpen,
                    firstShell_sub[i].param, 1));
              }
              secondShell.clear();
              for (int i = 0; i < secondShell_sub.length; i++) {
                secondShell.add(shellData(secondShell_sub[i].type, this.isOpen,
                    secondShell_sub[i].param, 1));
              }
            }

            dataSetCheck = 1;

//            print("check");
//            print("match_list_length : " + firstShell.length.toString() + ", " + secondShell.length.toString());
            return Stack(
              children: <Widget>[
                Container(
                    width: size.width,
                    height: size.height,
                    child: answer_finish
                        ? Stack(
                            children: <Widget>[
                              Image.asset(
                                  "assets/gamebox/img/effect/result_background.png"),
                              Center(
                                child: Result(
                                    level: widget.level,
                                    chapter: widget.chapter,
                                    stage: widget.stage,
                                    score: answer_finish_count,
                                    scoreLength: answer_all_length,
                                    sizeWidth:
                                        MediaQuery.of(context).size.width,
                                    resetGame: resetGame,
                                    resultNextGame: resultNextGame),
                              )
                            ],
                          )
                        : next_question
                            ? Column(
                                children: <Widget>[
//                              Positioned(
//                                left: 0,
//                                child: Opacity(
//                                    opacity: 0.5,
//                                    child: Container(
//                                      width: size.width,
//                                      height: size.height,
//                                      decoration: BoxDecoration(
//                                          borderRadius:
//                                              BorderRadius.circular(10),
//                                          color: Colors.black),
//                                    )),
//                              ),
                                  Image.asset(
                                    "assets/gamebox/img/match/18.png",
                                    fit: BoxFit.fill,
                                    width: size.width,
                                    height: size.height,
                                  ),
                                ],
                              )
                            : Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/gamebox/img/match/18.png",
                                    fit: BoxFit.fill,
                                    width: size.width,
                                    height: size.height,
                                  ),
                                ],
                              )),
//                Positioned(
//                  top: size.width / 4,
//                  child: questionStatus(
//                      question_all_length: 5,
//                      question_count: answer_count,
//                      width: size.width,
//                    ),
//                ),
                Positioned(
                  top: size.width / 3.5,
                  child: Container(
                    width: size.width - 20,
                    height: 360,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Stack(
                      children: <Widget>[
                        answer_finish
                            ? Text("")
                            : next_question
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                          "assets/gamebox/img/effect/yay.png")
                                    ],
                                  )
                                : Image.asset(
                                    "assets/gamebox/img/match/17.png",
                                    width: size.width - 20,
                                    height: 360,
                                    fit: BoxFit.fill,
                                  ),
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: next_question
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[],
                                )
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    rowData(1),
                                    rowData(2),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget rowData(int upDown) {
    return (upDown == 1)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              shell(firstShell[0].type, firstShell[0].isOpen,
                  firstShell[0].param, firstShell[0].opacity),
              shell(firstShell[1].type, firstShell[1].isOpen,
                  firstShell[1].param, firstShell[1].opacity),
              shell(firstShell[2].type, firstShell[2].isOpen,
                  firstShell[2].param, firstShell[2].opacity),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              shell(secondShell[0].type, secondShell[0].isOpen,
                  secondShell[0].param, secondShell[0].opacity),
              shell(secondShell[1].type, secondShell[1].isOpen,
                  secondShell[1].param, secondShell[1].opacity),
              shell(secondShell[2].type, secondShell[2].isOpen,
                  secondShell[2].param, secondShell[2].opacity),
            ],
          );
  }

  Widget shell(int type, bool isOpen, String param, double opacity) {
    this.isOpen = isOpen;
    this.opacity = opacity;
    return IgnorePointer(
      ignoring: answer_check ? true : this.isOpen,
      child: Opacity(
        opacity: opacity,
        child: GestureDetector(
          onTap: () {
            setState(() {
              print("opacity : " + opacity.toString());
              if (type == 1) {
                for (int i = 0; i < firstShell.length; i++) {
                  if (firstShell[i].type == 1 && firstShell[i].param == param) {
                    firstShell.removeAt(i);
                    firstShell.insert(i, shellData(type, true, param, 1));
                    rowData(1);
                    rowData(2);
                    if (answer_one == "") {
                      answer_one = param;
                      answer_one_list = 1;
                      answer_one_no = i;
                      answer_one_type = type;
                    } else if (answer_one != "" && answer_two == "") {
                      answer_two = param;
                      answer_two_list = 1;
                      answer_two_no = i;
                      answer_two_type = type;
                    }
                    break;
                  }
                  if (i == firstShell.length - 1) {
                    for (int i = 0; i < secondShell.length; i++) {
                      if (secondShell[i].type == 1 &&
                          secondShell[i].param == param) {
//                      print("type 1 second : " + type.toString() + ", " + param);
                        secondShell.removeAt(i);
                        secondShell.insert(i, shellData(type, true, param, 1));
                        rowData(1);
                        rowData(2);
                        if (answer_one == "") {
                          answer_one = param;
                          answer_one_list = 2;
                          answer_one_no = i;
                          answer_one_type = type;
                        } else if (answer_one != "" && answer_two == "") {
                          answer_two = param;
                          answer_two_list = 2;
                          answer_two_no = i;
                          answer_two_type = type;
                        }
                        break;
                      }
                    }
                  }
                }
              } else if (type == 2) {
                for (int i = 0; i < firstShell.length; i++) {
                  if (firstShell[i].type == 2 && firstShell[i].param == param) {
//                  print("type 2 fisrt : " + type.toString() + ", " + param);
                    firstShell.removeAt(i);
                    firstShell.insert(i, shellData(type, true, param, 1));
                    rowData(1);
                    rowData(2);
                    if (answer_one == "") {
                      answer_one = param;
                      answer_one_list = 1;
                      answer_one_no = i;
                      answer_one_type = type;
                    } else if (answer_one != "" && answer_two == "") {
                      answer_two = param;
                      answer_two_list = 1;
                      answer_two_no = i;
                      answer_two_type = type;
                    }
                    break;
                  }
                  if (i == firstShell.length - 1) {
                    for (int i = 0; i < secondShell.length; i++) {
                      if (secondShell[i].type == 2 &&
                          secondShell[i].param == param) {
//                      print("type 2 second : " + type.toString() + ", " + param);
                        secondShell.removeAt(i);
                        secondShell.insert(i, shellData(type, true, param, 1));
                        rowData(1);
                        rowData(2);
                        if (answer_one == "") {
                          answer_one = param;
                          answer_one_list = 2;
                          answer_one_no = i;
                          answer_one_type = type;
                        } else if (answer_one != "" && answer_two == "") {
                          answer_two = param;
                          answer_two_list = 2;
                          answer_two_no = i;
                          answer_two_type = type;
                        }
                        break;
                      }
                    }
                  }
                }
              }
            });
            print("answer : " + answer_one + ", " + answer_two);
            if (answer_one != "" && answer_two != "") {
              answer_check = true;
              if (answer_one.contains(answer_two) ||
                  answer_two.contains(answer_one)) {
//                  print("ok");
                setState(() {
                  answerCheck(1);
                });
              } else {
//                  print("no : " +
//                      answer_one_list.toString() +
//                      ", " +
//                      answer_one_no.toString() +
//                      ", " +
//                      answer_two_list.toString() +
//                      ", " +
//                      answer_two_no.toString());
                setState(() {
                  answerCheck(0);
                });
              }
            }
          },
          child: Container(
            width: 100,
            height: 100,
            child: Center(
              child: (type == 1)
                  ? this.isOpen
                      ? Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Image.network(
                            default_pic + param,
                            width: 50,
                            height: 50,
                          ),
                        )
                      : Text("")
                  : this.isOpen
                      ? Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            param,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'Jua',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Text(""),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage((type == 1)
                      ? this.isOpen ? shell1Open : shell1Close
                      : this.isOpen ? shell2Open : shell2Close)),
            ),
          ),
        ),
      ),
    );
  }
}

class shellData {
  final int type;
  final bool isOpen;
  final String param;
  final double opacity;

  shellData(this.type, this.isOpen, this.param, this.opacity);
}

class shellParam {
  final BoxDecoration boxDecoration;
  final String param;

  shellParam(this.boxDecoration, this.param);
}
