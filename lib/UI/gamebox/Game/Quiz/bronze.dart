import 'package:flutter/material.dart';
import 'package:lms_flutter/UI/gamebox/Game/Quiz/Bronze/bronze.dart';
import 'package:lms_flutter/model/Quiz/questionList.dart';
import 'package:lms_flutter/theme.dart';


import 'package:lms_flutter/bloc/speed_game_bloc.dart';



class QuizBronze {

  final List<QuestionList> qList;


  QuizBronze({this.qList});

  List<Widget> views = [];

  List<Widget> getViews() {
    for (QuestionList question in qList) {
      views.add(QuizB(
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

