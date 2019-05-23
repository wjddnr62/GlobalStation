import 'package:flutter/material.dart';
import 'package:lms_flutter/model/Speed/questionList.dart';
import 'package:lms_flutter/theme.dart';

import 'Gold/goldC.dart';
import 'Gold/goldD1.dart';
import 'Gold/goldD2.dart';
import 'Gold/goldE.dart';

//
//class SpeedGold extends StatefulWidget{
//
//  String type = "C";
//
//  @override
//  Gold createState() => Gold();
//}
//
//class Gold extends State<SpeedGold>{
//  @override
//  Widget build(BuildContext context) {
//    if(widget.type == "D-1")
//      return GoldD1();
//    else if(widget.type == "C")
//      return GoldC();
//    else if(widget.type == "D-2")
//      return GoldD2();
//    else
//      return GoldE();
//  }
//}

class SpeedGold{

  final List<QuestionList> qList;


  SpeedGold({this.qList});

  List<Widget> views = [];

  List<Widget> getViews(){
    for (QuestionList question in qList) {
      if (question.type == "D-1") {
        views.add(GoldC(
          level: question.level.substring(0, 1),
          stage: 1,
          question: question.contents,
          chapter: question.chapter,
          question_num: question.question_num,
          title: question.title,
        ));
      } else if (question.type == "D-2") {
        views.add(GoldC(
          level: question.level.substring(0, 1),
          stage: 1,
          question: question.contents,
          chapter: question.chapter,
          question_num: question.question_num,
          title: question.title,
        ));
      }else if (question.type == "C"){
        views.add(GoldC(
          level: question.level.substring(0, 1),
          stage: 1,
          question: question.contents,
          chapter: question.chapter,
          question_num: question.question_num,
          title: question.title,
        ));
      }else if(question.type == "E"){
        views.add(GoldC(
          level: question.level.substring(0, 1),
          stage: 1,
          question: question.contents,
          chapter: question.chapter,
          question_num: question.question_num,
          title: question.title,
        ));
      }
    }
    return views;
  }
}
