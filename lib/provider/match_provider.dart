import 'package:http/http.dart' as http;
import 'dart:async';

class MatchProvider {
  static final String defaultUrl = "https://ga.oig.kr/laon_api/api/match/";

  String getStage = defaultUrl + "stageList?";

  http.Client client = http.Client();

  Future<String> getStageList(String level, int chapter) async {
    final response = await client
        .get(getStage + 'level=' + level + '&chapter=' + chapter.toString());

    return response.body;
  }
}
