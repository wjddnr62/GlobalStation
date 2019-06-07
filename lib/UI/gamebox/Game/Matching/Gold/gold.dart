import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/UI/gamebox/public/Result.dart';
import 'package:lms_flutter/UI/gamebox/public/Timer.dart';
import 'package:lms_flutter/UI/gamebox/public/questionStatus.dart';
import 'package:lms_flutter/bloc/match_game_bloc.dart';
import 'package:lms_flutter/model/Match/answerList.dart';
import 'package:lms_flutter/model/UserInfo.dart';

class Gold extends StatefulWidget {
  final String level;
  final int chapter;
  final int stage;
  final int question_num;

  Gold({Key key, this.level, this.chapter, this.stage, this.question_num})
      : super(key: key);

  @override
  GoldM createState() => GoldM();
}

class GoldM extends State<Gold> {
  UserInfo userInfo = UserInfo();

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();

  String gloveClose = "assets/gamebox/img/match/glove_close.png";
  String gloveOpen = "assets/gamebox/img/match/glove_open.png";

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
  int answer_one_question_num = 0;

  int answer_two_list;
  int answer_two_no;
  int answer_two_type;
  String answer_two_param;
  int answer_two_question_num = 0;

  List<AnswerList> answerList = new List();

  int next_problem = 0;

  List<gloveData> glove = new List();
  List<gloveData> glove_sub = new List();
  List<gloveData> gloveTwo = new List();
  List<gloveData> gloveTwo_sub = new List();
  List<gloveData> gloveThree = new List();
  List<gloveData> gloveThree_sub = new List();

  int dataSetCheck = 0;
  double opacity = 1;

  bool isOpen = true;
  bool notYea = false;
  bool timeFinish = false;

  int memberLevel;

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
    var _duration = Duration(seconds: 3);
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
      answer_count = 0;
      next_problem = 1;
      dataSetCheck = 0;
    });
  }

  void answerReset() {
    setState(() {
      if (answer_one_list == 1) {
        glove.removeAt(answer_one_no);
        glove.insert(
            answer_one_no,
            gloveData(answer_one_type, false, answer_one, 1,
                answer_one_question_num));
      } else if (answer_one_list == 2) {
        gloveTwo.removeAt(answer_one_no);
        gloveTwo.insert(
            answer_one_no,
            gloveData(answer_one_type, false, answer_one, 1,
                answer_one_question_num));
      } else if (answer_one_list == 3) {
        gloveThree.removeAt(answer_one_no);
        gloveThree.insert(
            answer_one_no,
            gloveData(answer_one_type, false, answer_one, 1,
                answer_one_question_num));
      }
      if (answer_two_list == 1) {
        glove.removeAt(answer_two_no);
        glove.insert(
            answer_two_no,
            gloveData(answer_two_type, false, answer_two, 1,
                answer_two_question_num));
      } else if (answer_two_list == 2) {
        gloveTwo.removeAt(answer_two_no);
        gloveTwo.insert(
            answer_two_no,
            gloveData(answer_two_type, false, answer_two, 1,
                answer_two_question_num));
      } else if (answer_two_list == 3) {
        gloveThree.removeAt(answer_two_no);
        gloveThree.insert(
            answer_two_no,
            gloveData(answer_two_type, false, answer_two, 1,
                answer_two_question_num));
      }
      rowData(1);
      rowData(2);
      rowData(3);
      answer_one = "";
      answer_two = "";
      answer_one_question_num = 0;
      answer_two_question_num = 0;
      answer_check = false;
    });
  }

  void answerOk() {
    setState(() {
      if (answer_one_list == 1) {
        glove.removeAt(answer_one_no);
        glove.insert(
            answer_one_no,
            gloveData(answer_one_type, true, answer_one, 0.0,
                answer_one_question_num));
      } else if (answer_one_list == 2) {
        gloveTwo.removeAt(answer_one_no);
        gloveTwo.insert(
            answer_one_no,
            gloveData(answer_one_type, true, answer_one, 0.0,
                answer_one_question_num));
      } else if (answer_one_list == 3) {
        gloveThree.removeAt(answer_one_no);
        gloveThree.insert(
            answer_one_no,
            gloveData(answer_one_type, true, answer_one, 0.0,
                answer_one_question_num));
      }
      if (answer_two_list == 1) {
        glove.removeAt(answer_two_no);
        glove.insert(
            answer_two_no,
            gloveData(answer_two_type, true, answer_two, 0.0,
                answer_two_question_num));
      } else if (answer_two_list == 2) {
        gloveTwo.removeAt(answer_two_no);
        gloveTwo.insert(
            answer_two_no,
            gloveData(answer_two_type, true, answer_two, 0.0,
                answer_two_question_num));
      } else if (answer_two_list == 3) {
        gloveThree.removeAt(answer_two_no);
        gloveThree.insert(
            answer_two_no,
            gloveData(answer_two_type, true, answer_two, 0.0,
                answer_two_question_num));
      }
      rowData(1);
      rowData(2);
      rowData(3);
      answer_one = "";
      answer_two = "";
      answer_one_question_num = 0;
      answer_two_question_num = 0;
      answer_count += 1;
      print("count_up");
      print("all_length : " +
          answer_all_length.toString() +
          ", " +
          answer_finish_count.toString());
      if (answer_all_length != 8 && answer_count == 6) {
        audioCache.play("gamebox/audio/sucess_sound.wav");
        answer_finish_count += 1;
        answer_all_length += 1;
        if (answer_all_length == 8) {
          next_question = true;
          resultView();
        } else {
          print("next_question");
          next_question = true;
          nextQuestion();
          rowData(1);
          rowData(2);
          rowData(3);
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

  timerAnd() {
    setState(() {
      dataSetCheck = 0;
      rowData(1);
      rowData(2);
      rowData(3);
      next_question = true;
      nextQuestion();
      rowData(1);
      rowData(2);
      rowData(3);
      inVisible();
    });
  }

  void finishTimer() {
    setState(() {
      this.isOpen = true;
      if (answer_all_length != 5) {
        answer_all_length += 1;
        if (answer_all_length == 5) {
          next_question = true;
          resultView();
        } else {
          timeFinish = true;
          answer_one = "";
          answer_two = "";
          print("finishtime else");
          timerAnd();
        }
      }
    });
  }

  void resetGame() {
    setState(() {
      answer_finish = false;
      answer_all_length = 0;
      answer_finish_count = 0;
      answer_count = 0;
      answer_one = "";
      answer_two = "";
      answer_check = false;
      notYea = true;
      dataSetCheck = 0;
      rowData(1);
      rowData(2);
      rowData(3);
      next_question = true;
      nextQuestion();
      rowData(1);
      rowData(2);
      rowData(3);
      inVisible();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    memberLevel = userInfo.member_level;
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
                glove.clear();
                for (int i = 0; i < 4; i++) {
                  if (answerList[i].en == null || answerList[i].en == "") {
                    glove.add(gloveData(1, this.isOpen, answerList[i].ko, 1,
                        answerList[i].question_num));
                  } else {
                    glove.add(gloveData(2, this.isOpen, answerList[i].en, 1,
                        answerList[i].question_num));
                  }
                }
                gloveTwo.clear();
                for (int i = 4; i < 8; i++) {
                  if (answerList[i].en == null || answerList[i].en == "") {
                    gloveTwo.add(gloveData(1, this.isOpen, answerList[i].ko, 1,
                        answerList[i].question_num));
                  } else {
                    gloveTwo.add(gloveData(2, this.isOpen, answerList[i].en, 1,
                        answerList[i].question_num));
                  }
                }
                gloveThree.clear();
                for (int i = 8; i < 12; i++) {
                  if (answerList[i].en == null || answerList[i].en == "") {
                    gloveThree.add(gloveData(1, this.isOpen, answerList[i].ko,
                        1, answerList[i].question_num));
                  } else {
                    gloveThree.add(gloveData(2, this.isOpen, answerList[i].en,
                        1, answerList[i].question_num));
                  }
                }
                print("on");
                if (next_problem == 1) {
                  glove_sub.clear();
                  for (int i = 0; i < glove.length; i++) {
                    glove_sub.add(gloveData(glove[i].type, this.isOpen,
                        glove[i].param, 1, glove[i].question_num));
                  }
                  gloveTwo_sub.clear();
                  for (int i = 0; i < gloveTwo.length; i++) {
                    gloveTwo_sub.add(gloveData(gloveTwo[i].type, this.isOpen,
                        gloveTwo[i].param, 1, gloveTwo[i].question_num));
                  }
                  gloveThree_sub.clear();
                  for (int i = 0; i < gloveThree.length; i++) {
                    gloveThree_sub.add(gloveData(
                        gloveThree[i].type,
                        this.isOpen,
                        gloveThree[i].param,
                        1,
                        gloveThree[i].question_num));
                  }
                  next_problem = 2;
                }
              }
            } else if (next_problem == 2 && dataSetCheck != 1) {
              glove.clear();
              for (int i = 0; i < glove_sub.length; i++) {
                glove.add(gloveData(glove_sub[i].type, this.isOpen,
                    glove_sub[i].param, 1, glove_sub[i].question_num));
              }
              gloveTwo.clear();
              for (int i = 0; i < gloveTwo_sub.length; i++) {
                gloveTwo.add(gloveData(gloveTwo_sub[i].type, this.isOpen,
                    gloveTwo_sub[i].param, 1, gloveTwo_sub[i].question_num));
              }
              gloveThree.clear();
              for (int i = 0; i < gloveThree_sub.length; i++) {
                gloveThree.add(gloveData(
                    gloveThree_sub[i].type,
                    this.isOpen,
                    gloveThree_sub[i].param,
                    1,
                    gloveThree_sub[i].question_num));
              }
            }

            dataSetCheck = 1;
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
                                  sizeWidth: MediaQuery.of(context).size.width,
                                  resetGame: () => resetGame(),
                                  memberLevel: memberLevel,
                                  type: "MATCH",
                                ),
                              )
                            ],
                          )
                        : next_question
                            ? Stack(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/gamebox/img/match/18.png",
                                    fit: BoxFit.fill,
                                    width: size.width,
                                    height: size.height,
                                  ),
                                ],
                              )
                            : Stack(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/gamebox/img/match/18.png",
                                    fit: BoxFit.fill,
                                    width: size.width,
                                    height: size.height,
                                  ),
                                ],
                              )),
                Positioned(
                  top: size.width / 30,
                  child: Container(
                    width: size.width - 20,
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
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ),
                ),
                answer_finish
                    ? Text("")
                    : next_question
                        ? Text("")
                        : Positioned(
                            top: size.width / 15,
                            child: TimerBar(
                              width: size.width,
                              finishTimer: () => finishTimer(),
                              level: widget.level,
                            ),
                          ),
                answer_finish
                    ? Text("")
                    : Positioned(
                        top: size.width / 5,
                        child: QuestionStatus(
                          question_all_length: 8,
                          question_count: answer_all_length,
                          width: size.width,
                        ),
                      ),
                Positioned(
                  top: size.width / 3.5,
                  child: Container(
                    width: size.width - 20,
                    height: 420,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Stack(
                      children: <Widget>[
                        answer_finish
                            ? Text("")
                            : next_question
                                ? timeFinish
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Stack(
                                            children: <Widget>[
                                              Positioned(
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10.0),
                                                      child: Image.asset(
                                                        "assets/gamebox/img/match/match_gold.png",
                                                        width: size.width - 20,
                                                        height: 400,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )),
                                              ),
                                              Positioned(
                                                child: Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Image.asset(
                                                    "assets/gamebox/img/timeout.png",
                                                    width: size.width - 20,
                                                    height: 280,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    : notYea
                                        ? Text("")
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Stack(
                                                children: <Widget>[
                                                  Positioned(
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10.0,
                                                                  right: 10.0),
                                                          child: Image.asset(
                                                            "assets/gamebox/img/match/match_gold.png",
                                                            width:
                                                                size.width - 20,
                                                            height: 400,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        )),
                                                  ),
                                                  Positioned(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Image.asset(
                                                        "assets/gamebox/img/effect/yay.png",
                                                        width: size.width - 20,
                                                        height: 280,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                : Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Image.asset(
                                      "assets/gamebox/img/match/match_gold.png",
                                      width: size.width - 20,
                                      height: 420,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: next_question
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    rowData(1),
                                    rowData(2),
                                    rowData(3),
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
    if (answer_finish) {
      return Text("");
    } else {
      if (upDown == 1) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Glove(glove[0].type, glove[0].isOpen, glove[0].param,
                glove[0].opacity, glove[0].question_num),
            Glove(glove[1].type, glove[1].isOpen, glove[1].param,
                glove[1].opacity, glove[1].question_num),
            Glove(glove[2].type, glove[2].isOpen, glove[2].param,
                glove[2].opacity, glove[2].question_num),
            Glove(glove[3].type, glove[3].isOpen, glove[3].param,
                glove[3].opacity, glove[3].question_num),
          ],
        );
      } else if (upDown == 2) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Glove(gloveTwo[0].type, gloveTwo[0].isOpen, gloveTwo[0].param,
                gloveTwo[0].opacity, gloveTwo[0].question_num),
            Glove(gloveTwo[1].type, gloveTwo[1].isOpen, gloveTwo[1].param,
                gloveTwo[1].opacity, gloveTwo[1].question_num),
            Glove(gloveTwo[2].type, gloveTwo[2].isOpen, gloveTwo[2].param,
                gloveTwo[2].opacity, gloveTwo[2].question_num),
            Glove(gloveTwo[3].type, gloveTwo[3].isOpen, gloveTwo[3].param,
                gloveTwo[3].opacity, gloveTwo[3].question_num),
          ],
        );
      } else if (upDown == 3) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Glove(gloveThree[0].type, gloveThree[0].isOpen, gloveThree[0].param,
                gloveThree[0].opacity, gloveThree[0].question_num),
            Glove(gloveThree[1].type, gloveThree[1].isOpen, gloveThree[1].param,
                gloveThree[1].opacity, gloveThree[1].question_num),
            Glove(gloveThree[2].type, gloveThree[2].isOpen, gloveThree[2].param,
                gloveThree[2].opacity, gloveThree[2].question_num),
            Glove(gloveThree[3].type, gloveThree[3].isOpen, gloveThree[3].param,
                gloveThree[3].opacity, gloveThree[3].question_num),
          ],
        );
      }
    }
  }

  Widget Glove(
      int type, bool isOpen, String param, double opacity, int question_num) {
    this.isOpen = isOpen;
    this.opacity = opacity;
    return IgnorePointer(
      ignoring: answer_check ? true : this.isOpen,
      child: Opacity(
        opacity: opacity,
        child: GestureDetector(
          onTap: () {
            setState(() {
              print("touch : " +
                  type.toString() +
                  ", " +
                  param +
                  ", " +
                  question_num.toString());
              if (type == 1) {
                for (int i = 0; i < glove.length; i++) {
                  if (glove[i].type == 1 &&
                      glove[i].question_num == question_num) {
                    glove.removeAt(i);
                    glove.insert(
                        i, gloveData(type, true, param, 1, question_num));
                    rowData(1);
                    rowData(2);
                    rowData(3);
                    if (answer_one == "") {
                      answer_one = param;
                      answer_one_list = 1;
                      answer_one_no = i;
                      answer_one_type = type;
                      answer_one_question_num = question_num;
                    } else if (answer_one != "" && answer_two == "") {
                      answer_two = param;
                      answer_two_list = 1;
                      answer_two_no = i;
                      answer_two_type = type;
                      answer_two_question_num = question_num;
                    }
                    break;
                  }
                  if (i == glove.length - 1) {
                    for (int i = 0; i < gloveTwo.length; i++) {
                      if (gloveTwo[i].type == 1 &&
                          gloveTwo[i].question_num == question_num) {
                        gloveTwo.removeAt(i);
                        gloveTwo.insert(
                            i, gloveData(type, true, param, 1, question_num));
                        rowData(1);
                        rowData(2);
                        rowData(3);
                        if (answer_one == "") {
                          answer_one = param;
                          answer_one_list = 2;
                          answer_one_no = i;
                          answer_one_type = type;
                          answer_one_question_num = question_num;
                        } else if (answer_one != "" && answer_two == "") {
                          answer_two = param;
                          answer_two_list = 2;
                          answer_two_no = i;
                          answer_two_type = type;
                          answer_two_question_num = question_num;
                        }
                        break;
                      }
                      if (i == gloveTwo.length - 1) {
                        for (int i = 0; i < gloveThree.length; i++) {
                          if (gloveThree[i].type == 1 &&
                              gloveThree[i].question_num == question_num) {
                            gloveThree.removeAt(i);
                            gloveThree.insert(i,
                                gloveData(type, true, param, 1, question_num));
                            rowData(1);
                            rowData(2);
                            rowData(3);
                            if (answer_one == "") {
                              answer_one = param;
                              answer_one_list = 3;
                              answer_one_no = i;
                              answer_one_type = type;
                              answer_one_question_num = question_num;
                            } else if (answer_one != "" && answer_two == "") {
                              answer_two = param;
                              answer_two_list = 3;
                              answer_two_no = i;
                              answer_two_type = type;
                              answer_two_question_num = question_num;
                            }
                            break;
                          }
                        }
                      }
                    }
                  }
                }
              } else if (type == 2) {
                for (int i = 0; i < glove.length; i++) {
                  if (glove[i].type == 2 &&
                      glove[i].question_num == question_num) {
                    glove.removeAt(i);
                    glove.insert(
                        i, gloveData(type, true, param, 1, question_num));
                    rowData(1);
                    rowData(2);
                    rowData(3);
                    if (answer_one == "") {
                      answer_one = param;
                      answer_one_list = 1;
                      answer_one_no = i;
                      answer_one_type = type;
                      answer_one_question_num = question_num;
                    } else if (answer_one != "" && answer_two == "") {
                      answer_two = param;
                      answer_two_list = 1;
                      answer_two_no = i;
                      answer_two_type = type;
                      answer_two_question_num = question_num;
                    }
                    break;
                  }
                  if (i == glove.length - 1) {
                    for (int i = 0; i < gloveTwo.length; i++) {
                      if (gloveTwo[i].type == 2 &&
                          gloveTwo[i].question_num == question_num) {
//                      print("type 2 second : " + type.toString() + ", " + param);
                        gloveTwo.removeAt(i);
                        gloveTwo.insert(
                            i, gloveData(type, true, param, 1, question_num));
                        rowData(1);
                        rowData(2);
                        rowData(3);
                        if (answer_one == "") {
                          answer_one = param;
                          answer_one_list = 2;
                          answer_one_no = i;
                          answer_one_type = type;
                          answer_one_question_num = question_num;
                        } else if (answer_one != "" && answer_two == "") {
                          answer_two = param;
                          answer_two_list = 2;
                          answer_two_no = i;
                          answer_two_type = type;
                          answer_two_question_num = question_num;
                        }
                        break;
                      }
                      if (i == gloveTwo.length - 1) {
                        for (int i = 0; i < gloveThree.length; i++) {
                          if (gloveThree[i].type == 2 &&
                              gloveThree[i].question_num == question_num) {
                            gloveThree.removeAt(i);
                            gloveThree.insert(i,
                                gloveData(type, true, param, 1, question_num));
                            rowData(1);
                            rowData(2);
                            rowData(3);
                            if (answer_one == "") {
                              answer_one = param;
                              answer_one_list = 3;
                              answer_one_no = i;
                              answer_one_type = type;
                              answer_one_question_num = question_num;
                            } else if (answer_one != "" && answer_two == "") {
                              answer_two = param;
                              answer_two_list = 3;
                              answer_two_no = i;
                              answer_two_type = type;
                              answer_two_question_num = question_num;
                            }
                            break;
                          }
                        }
                      }
                    }
                  }
                }
              }
            });
            print("answer : " + answer_one + ", " + answer_two);
            if (answer_one_question_num != 0 && answer_two_question_num != 0) {
              answer_check = true;
              if (answer_one_question_num == answer_two_question_num &&
                  answer_two_question_num == answer_one_question_num) {
                setState(() {
                  answerCheck(1);
                });
              } else {
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
                          padding: EdgeInsets.only(
                              bottom: 20.0, left: 10.0, right: 10.0),
                          child: Text(
                            param,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Jua',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Text("")
                  : this.isOpen
                      ? Padding(
                          padding: EdgeInsets.only(
                              bottom: 20.0, left: 10.0, right: 10.0),
                          child: Text(
                            param,
                            style: TextStyle(
                              fontSize: 14,
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
                      ? this.isOpen ? gloveOpen : gloveClose
                      : this.isOpen ? gloveOpen : gloveClose)),
            ),
          ),
        ),
      ),
    );
  }
}

class gloveData {
  final int type;
  final bool isOpen;
  final String param;
  final double opacity;
  final int question_num;

  gloveData(
      this.type, this.isOpen, this.param, this.opacity, this.question_num);
}
