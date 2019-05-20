import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:lms_flutter/repository/Repository.dart';
import 'dart:async';
import 'dart:convert';

import 'package:lms_flutter/model/Quiz/questionList.dart';
import 'package:lms_flutter/model/Quiz/answerList.dart';

class SpeedGameBloc {
  final _repository = Repository();

  final _level = BehaviorSubject<String>();
  final _chapter = BehaviorSubject<int>();
  final _stage = BehaviorSubject<int>();

  int _answer = 0;
  int _question_num = 0;


  int get question_num => _question_num;

  set question_num(int value) {
    _question_num = value;
  }

  int get answer => _answer;

  set answer(int value) {
    _answer = value;
  }


  Observable<String> get level => _level.stream;

  Observable<int> get chapter => _chapter.stream;

  Observable<int> get stage => _stage.stream;

  Function(String) get getLevel => _level.sink.add;

  Function(int) get getChapter => _chapter.sink.add;

  Function(int) get getStage => _stage.sink.add;

  Stream<String> getAnswerList(int question_num) =>
      Stream.fromFuture(_repository.getQuizAnswerList(
          _level.value, _chapter.value, _stage.value, question_num));

  Stream<String> getQuestionList() =>
      Stream.fromFuture(_repository.getQuizQuestList(
          _level.value, _chapter.value, _stage.value));


  Future<String> getAnswer(int question_num) =>
      _repository.getQuizAnwer(
          _level.value, _chapter.value, _stage.value, question_num, answer);


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

final quizBloc = SpeedGameBloc();
