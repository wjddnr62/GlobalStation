import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:lms_flutter/UI/gamebox/Game/Quiz/quizDialog.dart';

class QuizProvider {
  static final String defaultUrl = "http://ga.oig.kr/laon_api_v2/api/quiz/";
  String getStage = defaultUrl + "stageList?";
  String getQuest = defaultUrl + "questList?";
  String getAnswer = defaultUrl + "answerList?";
  String checkAnswer = defaultUrl + "answer";

  http.Client client = http.Client();

  Future<String> getStageList(String level, int chapter) async {
    final response = await client
        .get(getStage + 'level=' + level + '&chapter=' + chapter.toString());

    return response.body;
  }

  Future<String> getQuestList(String level, int chapter, int stage) async {
    final response = await client.get(getQuest +
        'level=' +
        level +
        '&chapter=' +
        chapter.toString() +
        '&stage=' +
        stage.toString());

    return response.body;
  }

  Future<String> getAnswerList(
      String level, int chapter, int stage, int question_num) async {
    final response = await client.get(getAnswer +
        'level=' +
        level +
        '&chapter=' +
        chapter.toString() +
        "&stage=" +
        stage.toString() +
        "&question_num=" +
        question_num.toString());

    return response.body;
  }

  Future<String> getCheckAnswer (String level, int chapter, int stage,
      int question_num, int answer_num) async {
    final response = await client.post(checkAnswer, body: {
      'level': level,
      'chapter': chapter.toString(),
      'stage': stage.toString(),
      'question_num': question_num.toString(),
      'answer_num': question_num.toString(),
    });

    return response.body;
  }
}
