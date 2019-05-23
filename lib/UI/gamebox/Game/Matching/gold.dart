import 'package:flutter/material.dart';
import 'package:lms_flutter/model/Match/questionList.dart';

import 'Gold/gold.dart';

class MatchGold {
  final List<QuestionList> qList;

  MatchGold({this.qList});

  List<Widget> views = [];

  List<Widget> getViews() {
    for (QuestionList question in qList) {
      views.add(Gold(
        level: question.level.substring(0, 1),
        stage: question.stage,
        chapter: question.chapter,
        question_num: question.question_num,
      ));
    }
    return views;
  }
}