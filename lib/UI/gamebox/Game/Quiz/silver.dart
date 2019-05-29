import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

import 'Silver/silver.dart';

import 'package:lms_flutter/model/Quiz/questionList.dart';


class QuizSilver{

  final List<QuestionList> qList;


  QuizSilver({this.qList});

  List<Widget> views = [];

  List<Widget> getViews(){
    for (QuestionList question in qList) {
        views.add(QuizS(
          level: question.level.substring(0, 1),
          stage: question.stage,
          chapter: question.chapter,
          question_num: question.question_num,
          title: question.title,
        ));
    }
    return views;
  }
}
