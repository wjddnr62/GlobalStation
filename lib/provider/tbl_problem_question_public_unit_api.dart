import 'dart:async';

import 'package:http/http.dart' as http;

class QuestionPublicProvider {
  final String url = "http://isgec.oig.kr:8080/api/prutp/getPublic";

  Future<String> fetchGetQuestionPublic1List(http.Client client, int public_no) async {
    final response = await client.get(url + "1?public_no=" + public_no.toString());

    return response.body;
  }
}