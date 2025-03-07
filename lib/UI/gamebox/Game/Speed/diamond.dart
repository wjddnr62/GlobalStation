import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/model/Speed/questionList.dart';

import 'Diamond/diamondC.dart';
import 'Diamond/diamondD1.dart';
import 'Diamond/diamondD2.dart';
import 'Diamond/diamondE.dart';

class SpeedDiamond {
  final List<QuestionList> qList;
  AudioPlayer audioPlayer, background;
  TextEditingController controller;

  SpeedDiamond(
      {this.qList, this.audioPlayer, this.background, this.controller});

  List<Widget> views = [];

  List<Widget> getViews() {
    for (QuestionList question in qList) {
      if (question.type == "D-1") {
        views.add(DiamondD1(
            level: question.level.substring(0, 1),
            stage: question.stage,
            question: question.contents,
            chapter: question.chapter,
            question_num: question.question_num,
            title: question.title,
            audioPlayer: audioPlayer,
            background: background));
      } else if (question.type == "D-2") {
        views.add(DiamondD2(
          level: question.level.substring(0, 1),
          stage: question.stage,
          question: question.contents,
          chapter: question.chapter,
          question_num: question.question_num,
          title: question.title,
          audioPlayer: audioPlayer,
          background: background,
          controller: controller,
        ));
      } else if (question.type == "C") {
        views.add(DiamondC(
            level: question.level.substring(0, 1),
            stage: question.stage,
            question: question.contents,
            chapter: question.chapter,
            question_num: question.question_num,
            title: question.title,
            audioPlayer: audioPlayer,
            background: background));
      } else if (question.type == "E-1" || question.type == "E-2") {
        views.add(DiamondE(
          level: question.level.substring(0, 1),
          stage: question.stage,
          question: question.contents,
          chapter: question.chapter,
          question_num: question.question_num,
          title: question.title,
          audioPlayer: audioPlayer,
          background: background,
          controller: controller,
        ));
      }
    }
    return views;
  }
}
