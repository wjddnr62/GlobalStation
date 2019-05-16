import 'dart:async';

import 'package:http/http.dart' as http;

class ProblemUnitProvider {
  final String url = "http://isgec.oig.kr:8080/api/prut/getUnit";

  Future<String> fetchGetProblemUnit1List(http.Client client, String book_key) async {
    final response = await client.get(url + "1?book_key=" + book_key);

    return response.body;
  }
}