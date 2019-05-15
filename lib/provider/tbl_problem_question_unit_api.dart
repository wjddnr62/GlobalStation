import 'dart:async';

import 'package:http/http.dart' as http;

class QuestionProvider {
  final String url = "http://isgec.oig.kr:8080/api/prq/getQuestion";

  Future<String> fetchGetQuestion1List(http.Client client, String book_key,
      String type_no, String type_name) async {
    final response = await client.post(url + "1_detail", body: {
      "book_key": book_key,
      "type_no": type_no,
      "type_name": type_name
    });

    return response.body;
  }
}