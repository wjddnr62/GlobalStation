import 'package:http/http.dart' as http;
import 'dart:async';

class SpeedProvider {
  static final String defaultUrl = "http://ga.oig.kr/laon_api/api/speed/";
  String getStage = defaultUrl + "stageList?";
  String getQuest = defaultUrl + "questList?";
  String getAnswer = defaultUrl + "answerList?";
  String answerO =
      defaultUrl + "answer_o";
  String answerA =
      defaultUrl + "answer_a";

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

  Future<String> getAnswerO(String level, int chapter, int stage,
      int question_num, int answer) async {
    final response = await client.post(answerO, body: {
      'level': level,
      'chapter': chapter.toString(),
      'stage': stage.toString(),
      'question_num': question_num.toString(),
      'answer': answer.toString()
    });

    return response.body;
  }

  Future<String> getAnswerA(String level,int chapter, int stage, int question_num,
      String answer) async {
    print(answerA);
    print(level);
    print(chapter.toString());
    print(stage.toString());
    print(question_num.toString());
    print(answer);
    final response = await client.post(answerA,body: {
      'level': level,
      'chapter': chapter.toString(),
      'stage': stage.toString(),
      'question_num': question_num.toString(),
      'answer': answer
    });
    print(response);

    return response.body;
  }
}
