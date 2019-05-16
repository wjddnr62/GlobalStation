import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:lms_flutter/repository/Repository.dart';
import 'dart:async';
import 'dart:convert';

import 'package:lms_flutter/model/Speed/questionList.dart';
import 'package:lms_flutter/model/Speed/answerList.dart';

class SpeedGameBloc {
  final _repository = Repository();

  final _level = BehaviorSubject<String>();
  final _chapter = BehaviorSubject<int>();
  final _stage = BehaviorSubject<int>();

  Observable<String> get level => _level.stream;

  Observable<int> get chapter => _chapter.stream;

  Observable<int> get stage => _stage.stream;

  Function(String) get getLevel => _level.sink.add;

  Function(int) get getChapter => _chapter.sink.add;

  Function(int) get getStage => _stage.sink.add;

//  Future<String> getQuestionList() =>
//      _repository.getSpeedQuestList(_level.value, _chapter.value, _stage.value);

  Stream<String> getAnswerList(int question_num) =>
      Stream.fromFuture(_repository.getSpeedAnswerList(
          _level.value, _chapter.value, _stage.value, question_num));

  Stream<String> getQuestionList(){
    return Stream.fromFuture(_repository.getSpeedQuestList(_level.value, _chapter.value, _stage.value));
  }


  List<QuestionList> questListToList(String value) {
    List<QuestionList> questionList = json
        .decode(value)['data']
        .map<QuestionList>((json) => QuestionList.fromJson(json))
        .toList();

    return questionList;
  }

  List<AnswerList> answerListToList(String value) {
    List<AnswerList> answerList = json
        .decode(value)['data']
        .map<AnswerList>((json) => AnswerList.fromJson(json))
        .toList();

    return answerList;
  }
}

final speedBloc = SpeedGameBloc();
