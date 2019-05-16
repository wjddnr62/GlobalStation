import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lms_flutter/UI/bookbox/unit_start.dart';
import 'package:lms_flutter/bloc/answer_bloc.dart';
import 'package:lms_flutter/bloc/question_bloc.dart';
import 'package:lms_flutter/bloc/unit_bloc.dart';
import 'package:lms_flutter/model/answer.dart';
import 'package:lms_flutter/model/question.dart';
import 'package:lms_flutter/model/unit.dart';
import 'package:lms_flutter/model/unitData.dart';
import 'package:lms_flutter/theme.dart';

import '../unit_end.dart';

class phonics_1_SB_1 extends StatefulWidget {
  _phonics_1_SB_1 createState() => new _phonics_1_SB_1();
}

class _phonics_1_SB_1 extends State<phonics_1_SB_1> {
  final unitData unitdata = new unitData();

  String img_url = 'http://isgec.oig.kr/img/bookbox/SB/Phonics1/Unit%201/';

  String unit_level;
  String unit_name;
  String unit_sub_name;
  String book_key;
  int amount;

  Container unitContainer;

  int detail_no = 1;
  int page_num = 0;
  int page_end = 0;

  AppBar appBar_height;

  List<Unit> unitList = new List();
  List<ProblemUnit> problemunitList = new List();
  List<Question> questionList = new List();
  List<QuestionPublic> questionpublicList = new List();
  List<Answer> answerList = new List();

  bool unitSelect = false;
  bool questionSelect = false;
  bool public_use = false;
  bool answer_use = false;
  bool music_use = false;

  @override
  void initState() {
    super.initState();

      unit_level = unitdata.unit_level;
      unit_name = unitdata.unit_name;
      unit_sub_name = unitdata.unit_sub_name;
      book_key = unitdata.book_key;
      amount = unitdata.amount;

      unit_bloc.changebook_key(book_key);
      unit_bloc.getUnitList().then((value) {
        List<dynamic> unitValue = json.decode(value)['data'];
        print("getUnitLIst : " + unitValue.toString());

        for (int i = 0; i < unitValue.length; i++) {
          unitList.add(Unit(
              json.decode(value)['data'][i]['book_key'],
              json.decode(value)['data'][i]['book_page'],
              json.decode(value)['data'][i]['name'],
              json.decode(value)['data'][i]['num'],
              json.decode(value)['data'][i]['division_no'],
              json.decode(value)['data'][i]['division_name'],
              json.decode(value)['data'][i]['type_no'],
              json.decode(value)['data'][i]['type_name'],
              json.decode(value)['data'][i]['music'],
              json.decode(value)['data'][i]['answer_check']));
        }

        unit_bloc.getProblemUnit1List().then((value) {
          List<dynamic> problemunitValue = json.decode(value)['data'];
          print("getproblemUnitList : " + problemunitValue.toString());

          for (int i = 0; i < problemunitValue.length; i++) {
            problemunitList.add(ProblemUnit(
              json.decode(value)['data'][i]['book_key'],
              json.decode(value)['data'][i]['division_name'],
              json.decode(value)['data'][i]['division_no'],
              json.decode(value)['data'][i]['type_name'],
              json.decode(value)['data'][i]['type_no'],
              json.decode(value)['data'][i]['question_no'],
              json.decode(value)['data'][i]['public_no'],
            ));
          }

          getProblemData(unitList[0].type_no, unitList[0].type_name,
              problemunitList[0].public_no);
        });

      });
  }

  Future<void> DataSet() async {
    setState(() {
      questionSelect = false;
      music_use = false;
      answer_use = false;
      public_use = false;

      print("dataset_pageNum : " + page_num.toString());
      getProblemData(unitList[page_num].type_no, unitList[page_num].type_name,
          problemunitList[page_num].public_no);

      for (int i = 0; i< questionList.length; i++){
        print("detail_no : " + questionList[i].detail_no.toString());
      }

      detail_no = 1;
      unitContainer = unitContainer;
    });

  }

  Future<void> getProblemData(String type_no, String type_name, int public_no) async {
    question_bloc.changebook_key(book_key);
    question_bloc.changetype_name(type_name);
    question_bloc.changetype_no(type_no);

    answer_bloc.changebook_key(book_key);
    answer_bloc.changetype_name(type_name);
    answer_bloc.changetype_no(type_no);

    setState(() {
      if (unitList[page_num].music != null) {
        setState(() {
          music_use = true;
        });
      }

      try{
        question_bloc.getQuestion1List().then((value) {
          List<dynamic> questionValue = json.decode(value)['data'];

          questionList.clear();

          for (int i = 0; i < questionValue.length; i++) {
            setState(() {
              questionList.add(Question(
                json.decode(value)['data'][i]['book_key'],
                json.decode(value)['data'][i]['division_name'],
                json.decode(value)['data'][i]['division_no'],
                json.decode(value)['data'][i]['type_name'],
                json.decode(value)['data'][i]['type_no'],
                json.decode(value)['data'][i]['question_no'],
                json.decode(value)['data'][i]['question_sub'],
                json.decode(value)['data'][i]['detail_no'],
                json.decode(value)['data'][i]['question'],
                json.decode(value)['data'][i]['img'],
                json.decode(value)['data'][i]['ani_img'],
                json.decode(value)['data'][i]['quiz_status'],
              ));
            });
          }

          if (questionSelect == false) {
            questionSelect = true;
            print("question");
          }

//          detail_no = 1;
//          unitContainer = unitContainer;
          setState(() {
          });
        });
      }finally{
        setState(() {
          questionSelect = true;
        });
      }


      if (public_no != 0) {
        question_bloc.changepublic_no(public_no);
        question_bloc.getQuestionPublic1List().then((value) {
          List<dynamic> questionpublicValue = json.decode(value)['data'];

          questionpublicList.clear();

          for (int i = 0; i < questionpublicValue.length; i++) {
            setState(() {
              questionpublicList.add(QuestionPublic(
                json.decode(value)['data'][i]['public_no'],
                json.decode(value)['data'][i]['detail_no'],
                json.decode(value)['data'][i]['question'],
                json.decode(value)['data'][i]['question_img'],
                json.decode(value)['data'][i]['question_sub'],
              ));
            });
          }
          setState(() {
            public_use = true;
//            unitContainer = unitContainer;
          });
        });
      }

      answer_bloc.getAnswerList().then((value) {
        List<dynamic> answerValue = json.decode(value)['data'];
        print("answerValue : " + answerValue.toString());

        answerList.clear();

        for (int i = 0; i < answerValue.length; i++) {
          setState(() {
            answerList.add(Answer(
              json.decode(value)['data'][i]['book_key'],
              json.decode(value)['data'][i]['division_name'],
              json.decode(value)['data'][i]['division_no'],
              json.decode(value)['data'][i]['type_name'],
              json.decode(value)['data'][i]['type_no'],
              json.decode(value)['data'][i]['question_no'],
              json.decode(value)['data'][i]['detail_no'],
              json.decode(value)['data'][i]['answer'],
              json.decode(value)['data'][i]['sub_answer'],
            ));
          });
        }
        setState(() {
          for (int i = 0; i < answerList.length; i++) {
            if (answerList[i].answer != null &&
                answerList[i].sub_answer != null) {
              answer_use = true;
//              unitContainer = unitContainer;
              break;
            }
          }
        });
      });
    });


  }

  Widget A() {
    return Container(
      color: white,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        print(detail_no.toString() +
                            ", " +
                            questionList.length.toString() +
                            ", " +
                            page_num.toString());
                        setState(() {
                          if (detail_no == 1) {
                            unitSelect = false;
                          } else if (detail_no == questionList.length) {
                            detail_no -= 1;
                            unitContainer = A();
                          } else {
                            detail_no -= 1;
                            unitContainer = A();
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: backbtnbackgroundColor),
                        child: Center(
                          child: Icon(
                            Icons.chevron_left,
                            color: backbtnColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: bookboxmainColor),
                              child: Center(
                                child: Text(
                                  unitList[page_num].type_no,
                                  style: TextStyle(color: white, fontSize: 16),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                unitList[page_num].type_name,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text(
                      unitList[page_num].book_page.toString() + " P",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: questionSelect
                    ? RichText(
                        text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: '$detail_no',
                            style: TextStyle(
                                color: bookboxmainColor, fontSize: 16)),
                        TextSpan(
                            text: "/" + questionList.length.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 16))
                      ]))
                    : Text(""),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: questionSelect
                    ? Image.network(
                        img_url + questionList[detail_no - 1].img,
                        width: 200,
                      )
                    : Text(""),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget B() {
    return Container(
      color: white,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        print(detail_no.toString() +
                            ", " +
                            questionList.length.toString() +
                            ", " +
                            page_num.toString());
                        setState(() {
                          if (detail_no == 1) {
                            page_num -= 1;
                            DataSet();
                            unitContainer = A();
                          } else if (detail_no == questionList.length) {
                            detail_no -= 1;
                            unitContainer = B();
                          } else {
                            detail_no -= 1;
                            unitContainer = B();
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: backbtnbackgroundColor),
                        child: Center(
                          child: Icon(
                            Icons.chevron_left,
                            color: backbtnColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: bookboxmainColor),
                              child: Center(
                                child: Text(
                                  unitList[page_num].type_no,
                                  style: TextStyle(color: white, fontSize: 16),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                unitList[page_num].type_name,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text(
                      unitList[page_num].book_page.toString() + " P",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: questionSelect
                    ? RichText(
                        text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: '$detail_no',
                            style: TextStyle(
                                color: bookboxmainColor, fontSize: 16)),
                        TextSpan(
                            text: "/" + questionList.length.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 16))
                      ]))
                    : Text("t"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: questionSelect
                    ? Image.network(
                        img_url + questionList[detail_no - 1].img,
                        width: 200,
                        height: 200,
                      )
                    : Text("t"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: questionSelect
                    ? questionList[detail_no -1 ].question != null ? Text(
                        questionList[detail_no - 1].question,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ) : Text("e")
                    : Text("t"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget C() {
    return Container(
      width: 50,
      height: 50,
      color: Colors.black,
    );
  }

  Widget D() {
    return Container(
      width: 50,
      height: 50,
      color: Colors.black,
    );
  }

  Widget E() {
    return Container(
      width: 50,
      height: 50,
      color: Colors.black,
    );
  }

  Widget F() {
    return Container(
      width: 50,
      height: 50,
      color: Colors.black,
    );
  }

  Widget G() {
    return Container(
      width: 50,
      height: 50,
      color: Colors.black,
    );
  }

  Widget H() {
    return Container(
      width: 50,
      height: 50,
      color: Colors.black,
    );
  }

  Widget I() {
    return Container(
      width: 50,
      height: 50,
      color: Colors.black,
    );
  }

  Widget J() {
    return Container(
      width: 50,
      height: 50,
      color: Colors.black,
    );
  }

  Widget K() {
    return Container(
      width: 50,
      height: 50,
      color: Colors.black,
    );
  }

  Widget L() {
    return Container(
      width: 50,
      height: 50,
      color: Colors.black,
    );
  }

  Widget unitBody() {
    return Container(
      color: white,
      height: MediaQuery.of(context).size.height -
          appBar_height.preferredSize.height -
          MediaQuery.of(context).padding.top,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              unitSelect
                  ? unitContainer
                  : unitContainer = unitStart(
                      unit_level,
                      unit_name,
                      unit_sub_name,
                      appBar_height.preferredSize.height,
                      context),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (unitSelect == false) {
                      unitSelect = true;
                      unitContainer = A();
                      print("select");
                    } else if (unitSelect == true &&
                        unitContainer != unitStart) {
                      print("page_num : " + page_num.toString());

//                    if (page_num / amount != 1) {

                      if (page_end == 0) {
                        if (page_num == 0) {
                          if (detail_no < questionList.length) {
                            print("check");
                            detail_no += 1;
                            unitContainer = A();
                          } else if (detail_no == questionList.length) {
                            page_num += 1;
                            detail_no = 1;
                            DataSet();
                            unitContainer = B();
                          }
                          print("a : " +
                              detail_no.toString() +
                              ", " +
                              page_num.toString() +
                              ", " +
                              questionSelect.toString());
                        } else if (page_num == 1) {
                          if (detail_no < questionList.length) {
                            detail_no += 1;
                            unitContainer = B();
                          } else if (detail_no == questionList.length) {
                            detail_no = 1;
                            page_num += 1;
                            unitContainer = C();
                          }
                          print("b");
//                          page_num += 1;
                        } else if (page_num == 2) {
                          unitContainer = C();
                          page_num += 1;
                          print("c");
                        } else if (page_num == 3) {
                          unitContainer = D();
                          page_num += 1;
                          print("d");
                        } else if (page_num == 4) {
                          unitContainer = E();
                          page_num += 1;
                          print("e");
                        } else if (page_num == 5) {
                          unitContainer = F();
                          page_num += 1;
                          print("f");
                        } else if (page_num == 6) {
                          unitContainer = G();
                          page_num += 1;
                          print("g");
                        } else if (page_num == 7) {
                          unitContainer = H();
                          page_num += 1;
                          print("h");
                        } else if (page_num == 8) {
                          unitContainer = I();
                          page_num += 1;
                          print("i");
                        } else if (page_num == 9) {
                          unitContainer = J();
                          page_num += 1;
                          print("j");
                        } else if (page_num == 10) {
                          unitContainer = K();
                          page_num += 1;
                          print("k");
                        } else if (page_num == 11) {
                          unitContainer = L();
                          page_end = 1;
                          print("l");
                        }
                      } else if (page_end == 1) {
                        if (page_num != amount) {
                          page_num += 1;
                        }
                        unitContainer = unitEnd(unit_level, unit_name,
                            appBar_height.preferredSize.height, context);
                      }
                    } else {
                      unitContainer = A();
                    }

//                    } else {
//                      unitContainer = unitEnd(unit_level, unit_name,
//                          appBar_height.preferredSize.height, context);
//                      //끝 부분 표시
//                    }
                  });
                },
                child: Container(
                  width: 80,
                  height: 40,
//                color: yellowColor,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: greenColor),
                  child: Center(
                    child: Text(
                      "NEXT",
                      style: TextStyle(color: white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget appBar() {
    return appBar_height = AppBar(
      backgroundColor: white,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      title: Row(
        children: <Widget>[
          Container(
            width: 80,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), color: yellowColor),
            child: Center(
              child: Text(
                unit_level.substring(0, 1).toUpperCase() +
                    unit_level.substring(1),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Container(
              width: 200,
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: bookboxmainColor, width: 1)),
              child: PhysicalModel(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20.0),
                clipBehavior: Clip.antiAlias,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    bookboxmainColor,
                  ),
                  value: page_num / amount,
                ),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                print("close");
              },
              child: Icon(Icons.close),
            ),
          ),
        ),
      ],
    );
  }

  Widget unitMain() {
    return Container(
      child: Scaffold(
        appBar: appBar(),
        body: Container(
          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              unitBody(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return unitMain();
  }
}
