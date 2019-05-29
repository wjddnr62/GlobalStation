import 'package:flutter/material.dart';

import 'package:lms_flutter/model/Quiz/questionList.dart';

import 'Phonics/phonics.dart';

class QuizPhonics{

  final List<QuestionList> qList;


  QuizPhonics({this.qList});

  List<Widget> views = [];

  List<Widget> getViews(){
    for (QuestionList question in qList) {
        views.add(QuizP(
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
