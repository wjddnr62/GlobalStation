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

class Diamond extends StatefulWidget {
  final String level;
  final int chapter;
  final int stage;
  final int question_num;

  Diamond({Key key, this.level, this.chapter, this.stage, this.question_num})
      : super(key: key);

  @override
  DiamondM createState() => DiamondM();
}

class DiamondM extends State<Diamond> {
  UserInfo userInfo = UserInfo();

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();

  String cardClose = "assets/gamebox/img/match/card_close.png";
  String cardOpen = "assets/gamebox/img/match/card_open.png";

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

  List<cardData> card = new List();
  List<cardData> card_sub = new List();
  List<cardData> cardTwo = new List();
  List<cardData> cardTwo_sub = new List();
  List<cardData> cardThree = new List();
  List<cardData> cardThree_sub = new List();

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
        card.removeAt(answer_one_no);
        card.insert(
            answer_one_no,
            cardData(answer_one_type, false, answer_one, 1,
                answer_one_question_num));
      } else if (answer_one_list == 2) {
        cardTwo.removeAt(answer_one_no);
        cardTwo.insert(
            answer_one_no,
            cardData(answer_one_type, false, answer_one, 1,
                answer_one_question_num));
      } else if (answer_one_list == 3) {
        cardThree.removeAt(answer_one_no);
        cardThree.insert(
            answer_one_no,
            cardData(answer_one_type, false, answer_one, 1,
                answer_one_question_num));
      }
      if (answer_two_list == 1) {
        card.removeAt(answer_two_no);
        card.insert(
            answer_two_no,
            cardData(answer_two_type, false, answer_two, 1,
                answer_two_question_num));
      } else if (answer_two_list == 2) {
        cardTwo.removeAt(answer_two_no);
        cardTwo.insert(
            answer_two_no,
            cardData(answer_two_type, false, answer_two, 1,
                answer_two_question_num));
      } else if (answer_two_list == 3) {
        cardThree.removeAt(answer_two_no);
        cardThree.insert(
            answer_two_no,
            cardData(answer_two_type, false, answer_two, 1,
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
        card.removeAt(answer_one_no);
        card.insert(
            answer_one_no,
            cardData(answer_one_type, true, answer_one, 0.0,
                answer_one_question_num));
      } else if (answer_one_list == 2) {
        cardTwo.removeAt(answer_one_no);
        cardTwo.insert(
            answer_one_no,
            cardData(answer_one_type, true, answer_one, 0.0,
                answer_one_question_num));
      } else if (answer_one_list == 3) {
        cardThree.removeAt(answer_one_no);
        cardThree.insert(
            answer_one_no,
            cardData(answer_one_type, true, answer_one, 0.0,
                answer_one_question_num));
      }
      if (answer_two_list == 1) {
        card.removeAt(answer_two_no);
        card.insert(
            answer_two_no,
            cardData(answer_two_type, true, answer_two, 0.0,
                answer_two_question_num));
      } else if (answer_two_list == 2) {
        cardTwo.removeAt(answer_two_no);
        cardTwo.insert(
            answer_two_no,
            cardData(answer_two_type, true, answer_two, 0.0,
                answer_two_question_num));
      } else if (answer_two_list == 3) {
        cardThree.removeAt(answer_two_no);
        cardThree.insert(
            answer_two_no,
            cardData(answer_two_type, true, answer_two, 0.0,
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
        audioCache.play("gamebox/audio/sucess_sound.mp3");
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
                card.clear();
                cardTwo.clear();
                cardThree.clear();
                for (int i = 0; i < 4; i++) {
                  if (answerList[i].en == null || answerList[i].en == "") {
                    card.add(cardData(1, this.isOpen, answerList[i].ko, 1,
                        answerList[i].question_num));
                  } else {
                    card.add(cardData(2, this.isOpen, answerList[i].en, 1,
                        answerList[i].question_num));
                  }
                }
                for (int i = 4; i < 8; i++) {
                  if (answerList[i].en == null || answerList[i].en == "") {
                    cardTwo.add(cardData(1, this.isOpen, answerList[i].ko, 1,
                        answerList[i].question_num));
                  } else {
                    cardTwo.add(cardData(2, this.isOpen, answerList[i].en, 1,
                        answerList[i].question_num));
                  }
                }
                for (int i = 8; i < 12; i++) {
                  if (answerList[i].en == null || answerList[i].en == "") {
                    cardThree.add(cardData(1, this.isOpen, answerList[i].ko, 1,
                        answerList[i].question_num));
                  } else {
                    cardThree.add(cardData(2, this.isOpen, answerList[i].en, 1,
                        answerList[i].question_num));
                  }
                }
                print("on");
                if (next_problem == 1) {
                  card_sub.clear();
                  for (int i = 0; i < card.length; i++) {
                    card_sub.add(cardData(card[i].type, this.isOpen,
                        card[i].param, 1, card[i].question_num));
                  }
                  cardTwo_sub.clear();
                  for (int i = 0; i < cardTwo.length; i++) {
                    cardTwo_sub.add(cardData(cardTwo[i].type, this.isOpen,
                        cardTwo[i].param, 1, cardTwo[i].question_num));
                  }
                  cardThree_sub.clear();
                  for (int i = 0; i < cardThree.length; i++) {
                    cardThree_sub.add(cardData(cardThree[i].type, this.isOpen,
                        cardThree[i].param, 1, cardThree[i].question_num));
                  }
                  next_problem = 2;
                }
              }
            } else if (next_problem == 2 && dataSetCheck != 1) {
              card.clear();
              for (int i = 0; i < card_sub.length; i++) {
                card.add(cardData(card_sub[i].type, this.isOpen,
                    card_sub[i].param, 1, card_sub[i].question_num));
              }
              cardTwo.clear();
              for (int i = 0; i < cardTwo_sub.length; i++) {
                cardTwo.add(cardData(cardTwo_sub[i].type, this.isOpen,
                    cardTwo_sub[i].param, 1, cardTwo_sub[i].question_num));
              }
              cardThree.clear();
              for (int i = 0; i < cardThree_sub.length; i++) {
                cardThree.add(cardData(cardThree_sub[i].type, this.isOpen,
                    cardThree_sub[i].param, 1, cardThree_sub[i].question_num));
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
                                                        "assets/gamebox/img/match/match_dia.png",
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
                                                            "assets/gamebox/img/match/match_dia.png",
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
                                      "assets/gamebox/img/match/match_dia.png",
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
            Card(card[0].type, card[0].isOpen, card[0].param, card[0].opacity,
                card[0].question_num),
            Card(card[1].type, card[1].isOpen, card[1].param, card[1].opacity,
                card[1].question_num),
            Card(card[2].type, card[2].isOpen, card[2].param, card[2].opacity,
                card[2].question_num),
            Card(card[3].type, card[3].isOpen, card[3].param, card[3].opacity,
                card[3].question_num),
          ],
        );
      } else if (upDown == 2) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Card(cardTwo[0].type, cardTwo[0].isOpen, cardTwo[0].param,
                cardTwo[0].opacity, cardTwo[0].question_num),
            Card(cardTwo[1].type, cardTwo[1].isOpen, cardTwo[1].param,
                cardTwo[1].opacity, cardTwo[1].question_num),
            Card(cardTwo[2].type, cardTwo[2].isOpen, cardTwo[2].param,
                cardTwo[2].opacity, cardTwo[2].question_num),
            Card(cardTwo[3].type, cardTwo[3].isOpen, cardTwo[3].param,
                cardTwo[3].opacity, cardTwo[3].question_num),
          ],
        );
      } else if (upDown == 3) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Card(cardThree[0].type, cardThree[0].isOpen, cardThree[0].param,
                cardThree[0].opacity, cardThree[0].question_num),
            Card(cardThree[1].type, cardThree[1].isOpen, cardThree[1].param,
                cardThree[1].opacity, cardThree[1].question_num),
            Card(cardThree[2].type, cardThree[2].isOpen, cardThree[2].param,
                cardThree[2].opacity, cardThree[2].question_num),
            Card(cardThree[3].type, cardThree[3].isOpen, cardThree[3].param,
                cardThree[3].opacity, cardThree[3].question_num),
          ],
        );
      }
    }
  }

  Widget Card(
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
                for (int i = 0; i < card.length; i++) {
                  if (card[i].type == 1 &&
                      card[i].question_num == question_num) {
                    card.removeAt(i);
                    card.insert(
                        i, cardData(type, true, param, 1, question_num));
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
                  if (i == card.length - 1) {
                    for (int i = 0; i < cardTwo.length; i++) {
                      if (cardTwo[i].type == 1 &&
                          cardTwo[i].question_num == question_num) {
                        cardTwo.removeAt(i);
                        cardTwo.insert(
                            i, cardData(type, true, param, 1, question_num));
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
                      if (i == cardTwo.length - 1) {
                        for (int i = 0; i < cardThree.length; i++) {
                          if (cardThree[i].type == 1 &&
                              cardThree[i].question_num == question_num) {
                            cardThree.removeAt(i);
                            cardThree.insert(i,
                                cardData(type, true, param, 1, question_num));
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
                for (int i = 0; i < card.length; i++) {
                  if (card[i].type == 2 &&
                      card[i].question_num == question_num) {
                    card.removeAt(i);
                    card.insert(
                        i, cardData(type, true, param, 1, question_num));
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
                  if (i == card.length - 1) {
                    for (int i = 0; i < cardTwo.length; i++) {
                      if (cardTwo[i].type == 2 &&
                          cardTwo[i].question_num == question_num) {
//                      print("type 2 second : " + type.toString() + ", " + param);
                        cardTwo.removeAt(i);
                        cardTwo.insert(
                            i, cardData(type, true, param, 1, question_num));
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
                      if (i == cardTwo.length - 1) {
                        for (int i = 0; i < cardThree.length; i++) {
                          if (cardThree[i].type == 2 &&
                              cardThree[i].question_num == question_num) {
                            cardThree.removeAt(i);
                            cardThree.insert(i,
                                cardData(type, true, param, 1, question_num));
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
            height: 90,
            child: Center(
              child: (type == 1)
                  ? this.isOpen
                      ? Container(
                          width: 50,
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
                      : Text("")
                  : this.isOpen
                      ? Container(
                          width: 50,
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
                      ? this.isOpen ? cardOpen : cardClose
                      : this.isOpen ? cardOpen : cardClose),
                  fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}

class cardData {
  final int type;
  final bool isOpen;
  final String param;
  final double opacity;
  final int question_num;

  cardData(this.type, this.isOpen, this.param, this.opacity, this.question_num);
}
