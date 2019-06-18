import 'package:flutter/material.dart';
import 'package:lms_flutter/model/Match/questionList.dart';

import 'Phonics/phonics.dart';

class MatchPhonics{
  final List<QuestionList> qList;
  VoidCallback callback2;

  MatchPhonics({this.qList, this.callback2});

  List<Widget> views = [];

  List<Widget> getViews(){
    for (QuestionList question in qList) {
      views.add(Phonics(
          level: question.level.substring(0, 1),
        stage : question.stage,
        chapter: question.chapter,
        question_num: question.question_num,
        callback2: callback2
      ));
    }
    return views;
  }
}