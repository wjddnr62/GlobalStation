import 'package:flutter/material.dart';
import 'package:lms_flutter/model/Quiz/questionList.dart';
import 'package:lms_flutter/theme.dart';

import 'Diamond/diamond.dart';


class QuizDiamond{

  final List<QuestionList> qList;


  QuizDiamond({this.qList});

  List<Widget> views = [];

  List<Widget> getViews(){
    for (QuestionList question in qList) {
        views.add(QuizD(
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
