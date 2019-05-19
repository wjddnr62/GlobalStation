import 'package:flutter/material.dart';
import 'package:lms_flutter/UI/gamebox/Game/Quiz/Gold/gold.dart';
import 'package:lms_flutter/model/Quiz/questionList.dart';

class QuizGold{

  final List<QuestionList> qList;


  QuizGold({this.qList});

  List<Widget> views = [];

  List<Widget> getViews(){
    for (QuestionList question in qList) {
        views.add(QuizG(
          level: question.level.substring(0, 1),
          stage: 1,
          chapter: question.chapter,
          question_num: question.question_num,
          title: question.title,
        ));
    }
    return views;
  }
}
