import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lms_flutter/UI/gamebox/public/Result.dart';
import 'package:lms_flutter/UI/gamebox/public/Timer.dart';
import 'package:lms_flutter/UI/gamebox/public/questionStatus.dart';
import 'package:lms_flutter/bloc/match_game_bloc.dart';
import 'package:lms_flutter/model/Match/answerList.dart';
import 'package:lms_flutter/model/UserInfo.dart';

class Bronze extends StatefulWidget {
  final String level;
  final int chapter;
  final int stage;
  final int question_num;

  Bronze({Key key, this.level, this.chapter, this.stage, this.question_num})
      : super(key: key);

  @override
  BronzeM createState() => BronzeM();
}

class BronzeM extends State<Bronze> {
  UserInfo userInfo = UserInfo();

  String windowClose = "assets/gamebox/img/match/window_close.png";
  String windowOpen = "assets/gamebox/img/match/window_open.png";
  String whiteWindowClose = "assets/gamebox/img/match/white_window_close.png";
  String whiteWindowOpen = "assets/gamebox/img/match/white_window_open.png";

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

  List<windowData> window = new List();
  List<windowData> whiteWindow = new List();
  List<windowData> window_sub = new List();
  List<windowData> whiteWindow_sub = new List();

  List<windowParam> window_param = new List();

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
        window.removeAt(answer_one_no);
        window.insert(
            answer_one_no,
            windowData(answer_one_type, false, answer_one, 1,
                answer_one_question_num));
      } else if (answer_one_list == 2) {
        whiteWindow.removeAt(answer_one_no);
        whiteWindow.insert(
            answer_one_no,
            windowData(answer_one_type, false, answer_one, 1,
                answer_one_question_num));
      }
      if (answer_two_list == 1) {
        window.removeAt(answer_two_no);
        window.insert(
            answer_two_no,
            windowData(answer_two_type, false, answer_two, 1,
                answer_two_question_num));
      } else if (answer_two_list == 2) {
        whiteWindow.removeAt(answer_two_no);
        whiteWindow.insert(
            answer_two_no,
            windowData(answer_two_type, false, answer_two, 1,
                answer_two_question_num));
      }
      rowData(1);
      rowData(2);
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
        window.removeAt(answer_one_no);
        window.insert(
            answer_one_no,
            windowData(answer_one_type, true, answer_one, 0.0,
                answer_one_question_num));
      } else if (answer_one_list == 2) {
        whiteWindow.removeAt(answer_one_no);
        whiteWindow.insert(
            answer_one_no,
            windowData(answer_one_type, true, answer_one, 0.0,
                answer_one_question_num));
      }
      if (answer_two_list == 1) {
        window.removeAt(answer_two_no);
        window.insert(
            answer_two_no,
            windowData(answer_two_type, true, answer_two, 0.0,
                answer_two_question_num));
      } else if (answer_two_list == 2) {
        whiteWindow.removeAt(answer_two_no);
        whiteWindow.insert(
            answer_two_no,
            windowData(answer_two_type, true, answer_two, 0.0,
                answer_two_question_num));
      }
      rowData(1);
      rowData(2);
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
      if (answer_all_length != 5 && answer_count == 4) {
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

  timerAnd() {
    setState(() {
      dataSetCheck = 0;
      rowData(1);
      rowData(2);
      next_question = true;
      nextQuestion();
      rowData(1);
      rowData(2);
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
      next_question = true;
      nextQuestion();
      rowData(1);
      rowData(2);
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
                window.clear();
                whiteWindow.clear();
                for (int i = 0; i < 4; i++) {
                  if (answerList[i].en == null || answerList[i].en == "") {
                    if (i == 0) {
                      window.add(windowData(1, this.isOpen, answerList[i].ko, 1,
                          answerList[i].question_num));
                      print("type 1 0-4 window");
                    } else if (i % 2 == 0) {
                      window.add(windowData(1, this.isOpen, answerList[i].ko, 1,
                          answerList[i].question_num));
                      print("type 1 0-4 window");
                    } else if (i % 2 == 1) {
                      whiteWindow.add(windowData(1, this.isOpen,
                          answerList[i].ko, 1, answerList[i].question_num));
                      print("type 1 0-4 whitewindow");
                    }
                  } else {
                    if (i == 0) {
                      window.add(windowData(2, this.isOpen, answerList[i].en, 1,
                          answerList[i].question_num));
                      print('type 2 0-4 window');
                    } else if (i % 2 == 0) {
                      window.add(windowData(2, this.isOpen, answerList[i].en, 1,
                          answerList[i].question_num));
                      print('type 2 0-4 window');
                    } else if (i % 2 == 1) {
                      whiteWindow.add(windowData(2, this.isOpen,
                          answerList[i].en, 1, answerList[i].question_num));
                      print('type 2 0-4 whitewindow');
                    }
                  }
                }
                for (int i = 4; i < 8; i++) {
                  if (answerList[i].en == null || answerList[i].en == "") {
                    if (i % 2 == 0) {
                      window.add(windowData(1, this.isOpen, answerList[i].ko, 1,
                          answerList[i].question_num));
                      print('type 1 4-8 window');
                    } else if (i % 2 == 1) {
                      whiteWindow.add(windowData(1, this.isOpen,
                          answerList[i].ko, 1, answerList[i].question_num));
                      print('type 1 4-8 whitewindow');
                    }
                  } else {
                    if (i % 2 == 0) {
                      window.add(windowData(2, this.isOpen, answerList[i].en, 1,
                          answerList[i].question_num));
                      print('type 2 4-8 window');
                    } else if (i % 2 == 1) {
                      whiteWindow.add(windowData(2, this.isOpen,
                          answerList[i].en, 1, answerList[i].question_num));
                      print('type 2 4-8 whitewindow');
                    }
                  }
                }
                print("on");
                if (next_problem == 1) {
                  window_sub.clear();
                  for (int i = 0; i < window.length; i++) {
                    window_sub.add(windowData(window[i].type, this.isOpen,
                        window[i].param, 1, window[i].question_num));
                  }
                  whiteWindow_sub.clear();
                  for (int i = 0; i < whiteWindow.length; i++) {
                    whiteWindow_sub.add(windowData(
                        whiteWindow[i].type,
                        this.isOpen,
                        whiteWindow[i].param,
                        1,
                        whiteWindow[i].question_num));
                  }
                  next_problem = 2;
                }
              }
            } else if (next_problem == 2 && dataSetCheck != 1) {
              window.clear();
              for (int i = 0; i < window_sub.length; i++) {
                window.add(windowData(window_sub[i].type, this.isOpen,
                    window_sub[i].param, 1, window_sub[i].question_num));
              }
              whiteWindow.clear();
              for (int i = 0; i < whiteWindow_sub.length; i++) {
                whiteWindow.add(windowData(
                    whiteWindow_sub[i].type,
                    this.isOpen,
                    whiteWindow_sub[i].param,
                    1,
                    whiteWindow_sub[i].question_num));
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
                                ),
                              )
                            ],
                          )
                        : next_question
                            ? Column(
                                children: <Widget>[
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
                          child: Image.asset("assets/gamebox/img/close_button.png"),
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ),
                ),
                answer_finish
                    ? Text("")
                    : Positioned(
                        top: size.width / 15,
                        child: TimerBar(
                          width: size.width,
                          finishTimer: () => finishTimer(),
                        ),
                      ),
                answer_finish
                    ? Text("")
                    : Positioned(
                        top: size.width / 5,
                        child: QuestionStatus(
                          question_all_length: 5,
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
                                          Align(
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              "assets/gamebox/img/effect/nope.png",
                                              width: 300,
                                              height: 300,
                                            ),
                                          )
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
                                              Align(
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                  "assets/gamebox/img/effect/yay.png",
                                                  width: 300,
                                                  height: 300,
                                                ),
                                              )
                                            ],
                                          )
                                : Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Image.asset(
                                      "assets/gamebox/img/match/match_bronze.png",
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
    return answer_finish
        ? Text("")
        : (upDown == 1)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  winDow(
                      whiteWindow[0].type,
                      whiteWindow[0].isOpen,
                      whiteWindow[0].param,
                      whiteWindow[0].opacity,
                      whiteWindow[0].question_num),
                  winDow(window[0].type, window[0].isOpen, window[0].param,
                      window[0].opacity, window[0].question_num),
                  winDow(
                      whiteWindow[1].type,
                      whiteWindow[1].isOpen,
                      whiteWindow[1].param,
                      whiteWindow[1].opacity,
                      whiteWindow[1].question_num),
                  winDow(window[1].type, window[1].isOpen, window[1].param,
                      window[1].opacity, window[1].question_num),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  winDow(
                      whiteWindow[2].type,
                      whiteWindow[2].isOpen,
                      whiteWindow[2].param,
                      whiteWindow[2].opacity,
                      whiteWindow[2].question_num),
                  winDow(window[2].type, window[2].isOpen, window[2].param,
                      window[2].opacity, window[2].question_num),
                  winDow(
                      whiteWindow[3].type,
                      whiteWindow[3].isOpen,
                      whiteWindow[3].param,
                      whiteWindow[3].opacity,
                      whiteWindow[3].question_num),
                  winDow(window[3].type, window[3].isOpen, window[3].param,
                      window[3].opacity, window[3].question_num),
                ],
              );
  }

  Widget winDow(
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
              if (type == 1) {
                for (int i = 0; i < window.length; i++) {
                  if (window[i].type == 1 &&
                      window[i].question_num == question_num) {
                    window.removeAt(i);
                    window.insert(
                        i, windowData(type, true, param, 1, question_num));
                    rowData(1);
                    rowData(2);
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
                  if (i == window.length - 1) {
                    for (int i = 0; i < whiteWindow.length; i++) {
                      if (whiteWindow[i].type == 1 &&
                          whiteWindow[i].question_num == question_num) {
                        whiteWindow.removeAt(i);
                        whiteWindow.insert(
                            i, windowData(type, true, param, 1, question_num));
                        rowData(1);
                        rowData(2);
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
                    }
                  }
                }
              } else if (type == 2) {
                for (int i = 0; i < window.length; i++) {
                  if (window[i].type == 2 &&
                      window[i].question_num == question_num) {
                    window.removeAt(i);
                    window.insert(
                        i, windowData(type, true, param, 1, question_num));
                    rowData(1);
                    rowData(2);
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
                  if (i == window.length - 1) {
                    for (int i = 0; i < whiteWindow.length; i++) {
                      if (whiteWindow[i].type == 2 &&
                          whiteWindow[i].question_num == question_num) {
//                      print("type 2 second : " + type.toString() + ", " + param);
                        whiteWindow.removeAt(i);
                        whiteWindow.insert(
                            i, windowData(type, true, param, 1, question_num));
                        rowData(1);
                        rowData(2);
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
                      ? Text(
                          param,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: 'Jua',
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Text("")
                  : this.isOpen
                      ? Text(
                          param,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: 'Jua',
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Text(""),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage((type == 1)
                      ? this.isOpen ? windowOpen : windowClose
                      : this.isOpen ? whiteWindowOpen : whiteWindowClose)),
            ),
          ),
        ),
      ),
    );
  }
}

class windowData {
  final int type;
  final bool isOpen;
  final String param;
  final double opacity;
  final int question_num;

  windowData(
      this.type, this.isOpen, this.param, this.opacity, this.question_num);
}

class windowParam {
  final BoxDecoration boxDecoration;
  final String param;

  windowParam(this.boxDecoration, this.param);
}
