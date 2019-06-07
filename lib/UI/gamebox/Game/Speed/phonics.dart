import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/model/Speed/questionList.dart';

import 'Phonics/phonicsA.dart';
import 'Phonics/phonicsB.dart';

class SpeedPhonics {
  final List<QuestionList> qList;
  AudioPlayer audioPlayer, background;
  TextEditingController controller;

  SpeedPhonics({this.qList, this.audioPlayer, this.background, this.controller});

  List<Widget> views = [];

  List<Widget> getViews() {
    for (QuestionList question in qList) {
      if (question.type == "A") {
        print("AA");
        views.add(PhonicsA(
            level: question.level.substring(0, 1),
            stage: question.stage,
            chapter: question.chapter,
            question_num: question.question_num,
            title: question.title,
            audioPlayer: audioPlayer,
            background: background));
      } else if (question.type == "B") {
        print("BB");
        views.add(PhonicsB(
            level: question.level.substring(0, 1),
            stage: question.stage,
            chapter: question.chapter,
            question_num: question.question_num,
            title: question.title,
            audioPlayer: audioPlayer,
            background: background));
      }
    }
    print("viewslen : " + views.length.toString());
    return views;
  }
}
