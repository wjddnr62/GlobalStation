import 'package:flutter/material.dart';
import 'package:lms_flutter/model/Match/questionList.dart';

import 'Phonics/phonics.dart';

class MatchPhonics{
  final List<QuestionList> qList;

  MatchPhonics({this.qList});

  List<Widget> views = [];

  List<Widget> getViews(){
    for (QuestionList question in qList) {
      views.add(Phonics(
          level: question.level.substring(0, 1),
        stage : 1,
        chapter: question.chapter,
        question_num: question.question_num,
      ));
    }
    return views;
  }
}