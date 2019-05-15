import 'dart:async';

import 'package:http/http.dart' as http;

class AnswerProvider {
  final String url = "http://isgec.oig.kr:8080/api/answer/getAnswer_detail";

  Future<String> fetchGetAnswerList(http.Client client, String book_key, String type_no, String type_name) async {
    final response = await client.post(url, body: {"book_key":book_key, "type_no":type_no, "type_name":type_name});

    return response.body;
  }
}