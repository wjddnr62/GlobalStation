import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class MatchProvider {
  static final String defaultUrl = "http://ga.oig.kr/laon_api_v2/api/match/";

  String getStage = defaultUrl + "stageList?";
  String getQuest = defaultUrl + "questList?";
  String getAnswer = defaultUrl + "answerList?";

  http.Client client = http.Client();

  Future<String> getStageList(String level, int chapter) async {
    final response = await client
        .get(getStage + 'level=' + level + '&chapter=' + chapter.toString());

    return response.body;
  }

  Future<String> getQuestList(String level, int chapter, int stage) async {
    final response = await http.get(getQuest +
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
      String body = utf8.decode(response.bodyBytes);
    return body;
  }


}
