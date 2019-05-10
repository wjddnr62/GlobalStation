import 'dart:async';

import 'package:http/http.dart' as http;

class BookProvider {
  final String url = "http://isgec.oig.kr:8080/api/book/getBooklist";

  Future<String> fetchGetBookList(http.Client client, String class_str) async {
    final response = await client.get(url + "?class_str=" + class_str);

    return response.body;
  }
}
