import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

import 'Silver/silverC.dart';
import 'Silver/silverD1.dart';
import 'Silver/silverD2.dart';
import 'Silver/silverE.dart';

import 'package:lms_flutter/model/Speed/questionList.dart';


//class SpeedSilver extends StatefulWidget{
//
//  String type = "E";
//
//  @override
//  Silver createState() => Silver();
//}
//
//class Silver extends State<SpeedSilver>{
//  @override
//  Widget build(BuildContext context) {
//   if(widget.type == "D-1")
//     return SilverD1();
//   else if(widget.type == "C")
//     return SilverC();
//   else if(widget.type == "D-2")
//     return SilverD2();
//   else
//     return SilverE();
//  }
//}
class SpeedSilver{

  final List<QuestionList> qList;


  SpeedSilver({this.qList});

  List<Widget> views = [];

  List<Widget> getViews(){
    for (QuestionList question in qList) {
      if (question.type == "D-1") {
        views.add(SilverD1(
          level: question.level.substring(0, 1),
          stage: question.stage,
          question: question.contents,
          chapter: question.chapter,
          question_num: question.question_num,
          title: question.title,
        ));
      } else if (question.type == "D-2") {
        views.add(SilverD2(
          level: question.level.substring(0, 1),
          stage: question.stage,
          question: question.contents,
          chapter: question.chapter,
          question_num: question.question_num,
          title: question.title,
        ));
      }else if (question.type == "C"){
        views.add(SilverC(
          level: question.level.substring(0, 1),
          stage: question.stage,
          question: question.contents,
          chapter: question.chapter,
          question_num: question.question_num,
          title: question.title,
        ));
      }else if(question.type == "E"){
        views.add(SilverE(
          level: question.level.substring(0, 1),
          stage: question.stage,
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
