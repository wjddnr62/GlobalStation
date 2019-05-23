import 'package:flutter/material.dart';
import 'package:lms_flutter/model/Match/questionList.dart';

import 'Bronze/bronze.dart';

class MatchBronze {
  final List<QuestionList> qList;

  MatchBronze({this.qList});

  List<Widget> views = [];

  List<Widget> getViews() {
    for (QuestionList question in qList) {
      views.add(Bronze(
        level: question.level.substring(0, 1),
        stage: question.stage,
        chapter: question.chapter,
        question_num: question.question_num,
      ));
    }
    return views;
  }
}
